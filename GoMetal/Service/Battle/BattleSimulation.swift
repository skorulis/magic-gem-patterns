//Created by Alexander Skorulis on 25/8/2024.

import Foundation

final class BattleSimulation {
    
    private let deltaProvider = DeltaProvider()
    private let castFactory: SpellCastSimulationFactory
    var battle: Battle
    private var spellSimulation: SpellCastSimulation
    
    init(castFactory: SpellCastSimulationFactory, caster: Caster) {
        self.castFactory = castFactory
        self.battle = Battle(caster: caster)
        spellSimulation = castFactory.make(spellProvider: { caster.activeSpell})
        spellSimulation.didFinishCast = { [weak self] in self?.didCast(spell: $0) }
        deltaProvider.onStep = { [weak self] in self?.step(delta: $0) }
        spellSimulation.start()
        deltaProvider.start()
    }
    
    func start() {
        deltaProvider.start()
    }
    
    func step(delta: Float) {
        spellSimulation.step(delta: delta)
        for var particle in battle.particles {
            particle.position += (particle.velocity * delta)
        }
        battle.particles = battle.particles.filter { $0.position.length < 1 }
    }
    
    func didCast(spell: CastResult) {
        print("Battle cast")
        for energy in spell.energy {
            let particle = BattleParticle(
                position: .zero,
                velocity: energy.velocity,
                power: energy.power
            )
        }
    }
}
