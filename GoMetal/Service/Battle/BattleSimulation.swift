//Created by Alexander Skorulis on 25/8/2024.

import Foundation

@Observable final class BattleSimulation {
    
    private let deltaProvider = DeltaProvider()
    private let castFactory: SpellCastSimulationFactory
    var battle: Battle
    private var spellSimulation: SpellCastSimulation
    
    init(castFactory: SpellCastSimulationFactory, caster: Caster) {
        self.castFactory = castFactory
        self.battle = Battle(caster: caster)
        spellSimulation = castFactory.make(spellProvider: { caster.activeSpell})
        spellSimulation.didFinishCast = { [weak self] in self?.didCast(spell: $0, caster: caster) }
        deltaProvider.onStep = { [weak self] in self?.step(delta: $0) }
        spellSimulation.start()
        deltaProvider.start()
    }
    
    func start() {
        deltaProvider.start()
    }
    
    func step(delta: Float) {
        spellSimulation.step(delta: delta)
        for (index, var particle) in battle.particles.enumerated() {
            particle.position += (particle.velocity * delta)
            battle.particles[index] = particle
        }
        battle.particles = battle.particles.filter { $0.position.length < 1 }
    }
    
    func didCast(spell: CastResult, caster: Caster) {
        for energy in spell.energy {
            let particle = BattleParticle(
                position: caster.position,
                velocity: energy.velocity,
                power: energy.power
            )
            self.battle.particles.append(particle)
        }
    }
}
