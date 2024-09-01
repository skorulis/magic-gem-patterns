//Created by Alexander Skorulis on 25/8/2024.

import Foundation

@Observable final class BattleSimulation {
    
    private let deltaProvider = DeltaProvider()
    private let castFactory: SpellCastSimulationFactory
    var battle: Battle
    private var spellSimulations: [SpellCastSimulation]
    
    init(castFactory: SpellCastSimulationFactory, casters: [Caster]) {
        self.castFactory = castFactory
        self.battle = Battle(casters: casters)
        self.spellSimulations = casters.map { caster in
            castFactory.make(spellProvider: { caster.activeSpell})
        }
        deltaProvider.onStep = { [weak self] in self?.step(delta: $0) }
        for i in 0..<casters.count {
            spellSimulations[i].didFinishCast = { [weak self] in self?.didCast(spell: $0, caster: casters[i]) }
            spellSimulations[i].start()
        }
        
        deltaProvider.start()
    }
    
    func start() {
        deltaProvider.start()
    }
    
    func step(delta: Float) {
        spellSimulations.forEach { $0.step(delta: delta) }
        for (index, var particle) in battle.particles.enumerated() {
            particle.position += (particle.velocity * delta)
            battle.particles[index] = particle
        }
        battle.particles = battle.particles.filter { $0.position.length < 1 }
    }
    
    func didCast(spell: CastResult, caster: Caster) {
        for energy in spell.energy {
            let vel = energy.velocity.rotated(by: caster.heading) * Battle.Constants.spellToBattleSpeed
            let particle = BattleParticle(
                position: caster.position,
                velocity: vel,
                power: energy.power
            )
            self.battle.particles.append(particle)
        }
    }
}
