//Created by Alexander Skorulis on 25/8/2024.

import Foundation
import VectorMath

final class BattleSimulation: ObservableObject {
    
    private let deltaProvider = DeltaProvider()
    private let castFactory: SpellCastSimulationFactory
    @Published var battle: Battle
    private var spellSimulations: [SpellCastSimulation] = []
    
    init(castFactory: SpellCastSimulationFactory, casters: [Caster]) {
        self.castFactory = castFactory
        self.battle = Battle(casters: casters)
        
        for i in 0..<casters.count {
            let simulation = castFactory.make(
                spellProvider: { [unowned self] in self.battle.casters[i].activeSpell }
            )
            spellSimulations.append(simulation)
        }
        
        deltaProvider.onStep = { [weak self] in self?.step(delta: $0) }
        for i in 0..<casters.count {
            spellSimulations[i].didFinishCast = { [weak self] in self?.didCast(spell: $0, caster: casters[i]) }
            spellSimulations[i].start()
        }
        
        deltaProvider.start()
    }
    
    func change(spell: Spell) {
        battle.casters[0].activeSpell = spell
        spellSimulations[0].start()
    }
    
    func start() {
        deltaProvider.start()
    }
    
    func step(delta: Float) {
        spellSimulations.forEach { $0.step(delta: delta) }
        for (index, var particle) in battle.particles.enumerated() {
            particle.position += (particle.velocity * delta)
            if let hit = casterInteraction(particle: &particle, delta: delta) {
                print("Hit: \(hit.id)")
                particle.flags.insert(.isDead)
            }
            battle.particles[index] = particle
        }
        battle.particles = battle.particles.filter { $0.position.length < 1 && !$0.flags.contains(.isDead) }
    }
    
    private func didCast(spell: CastResult, caster: Caster) {
        for energy in spell.energy {
            let vel = energy.velocity.rotated(by: caster.heading) * Battle.Constants.spellToBattleSpeed
            let particle = BattleParticle(
                casterID: caster.id,
                position: caster.position,
                velocity: vel,
                power: energy.power
            )
            self.battle.particles.append(particle)
        }
    }
    
    private func casterInteraction(particle: inout BattleParticle, delta: Float) -> Caster? {
        for caster in battle.casters {
            if caster.id == particle.casterID {
                continue
            }
            let dir = (caster.position - particle.position)
            let dist = dir.length
            
            if dist < Battle.Constants.casterSize / 2 {
                return caster
            }
            
            let force = dir.normalized() / (dist * dist)
            particle.velocity += force * delta * Battle.Constants.attractionMultiplier
        }
        return nil
    }
}
