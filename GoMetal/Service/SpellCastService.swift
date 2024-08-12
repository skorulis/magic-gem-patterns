//  Created by Alexander Skorulis on 10/7/2024.

import Foundation

final class SpellCastService {
    
    func update(context: inout SpellContext, delta: Float) {
        let pattern = context.spell.pattern
        var removedIndexes: [Int] = []
        var newEnergy: [SpellEnergy] = []
        for (i, var energy) in context.energy.enumerated() {
            let force = pattern.force(at: energy.position)
            energy.position += (energy.velocity * delta)
            energy.velocity -= energy.velocity * 0.5 * delta
            energy.velocity += (force.total * delta)
            energy.power += 3 * delta
            
            if let gem = hitGem(spell: context.spell, energy: energy) {
                energy.gemIDs.insert(gem.id)
                newEnergy.append(contentsOf: split(pattern: pattern, energy: energy, gem: gem))
                removedIndexes.append(i)
            } else {
                context.energy[i] = energy
            }
            
            let t = pattern.time(position: energy.position)
            if t <= 0.1 && context.completeness >= 0.9 {
                context.completeness = 1
            } else {
                context.completeness = max(context.completeness, t)
            }
        }
        for i in removedIndexes.reversed() {
            context.energy.remove(at: i)
        }
        context.energy.append(contentsOf: newEnergy)
    }
    
    private func split(pattern: PatternProtocol, energy: SpellEnergy, gem: GemPosition) -> [SpellEnergy] {
        let pos = energy.position
        let splitAngles = gem.gem.shape.splitAngles
        
        return splitAngles.map { angle in
            let vel = energy.velocity.rotated(by: angle)
            return SpellEnergy(
                gemIDs: energy.gemIDs,
                time: energy.time,
                position: pos,
                velocity: vel,
                power: energy.power/2
            )
        }
    }
    
    private func hitGem(spell: Spell, energy: SpellEnergy) -> GemPosition? {
        for gem in spell.gems {
            if energy.gemIDs.contains(gem.id) { continue }
            let pos = spell.pattern.position(time: gem.time)
            let dist = (energy.position - pos).length
            if dist < gem.gem.size.x {
                return gem
            }
        }
        return nil
    }
    
    func result(context: SpellContext) -> CastResult {
        var power: Float = 0
        var maxDistance: Float = 0
        let pattern = context.spell.pattern
        for energy in context.energy {
            power += energy.power
            let distance = (energy.position - pattern.position(time: 1)).length
            maxDistance = max(distance, maxDistance)
        }
        
        return .init(
            power: power,
            deviance: maxDistance
        )
    }
    
}
