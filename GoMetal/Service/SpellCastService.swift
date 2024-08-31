//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import VectorMath

final class SpellCastService {
    
    private let shapeMatcher: SpellShapeMatcher
    
    init(shapeMatcher: SpellShapeMatcher) {
        self.shapeMatcher = shapeMatcher
    }
    
    func update(context: inout SpellContext, delta: Float) {
        let pattern = context.spell.pattern
        var removedIndexes: [Int] = []
        var newEnergy: [SpellEnergy] = []
    
        context.currentTime += delta
        for (i, var energy) in context.energy.enumerated() {
            let force = pattern.force(at: energy.position)
            energy.position += (energy.velocity * delta)
            applyDrag(energy: &energy, force: force, delta: delta)
            energy.velocity += (force.total * delta)
            energy.power += 3 * delta
            
            if let gem = hitGem(spell: context.spell, energy: energy) {
                charge(context: &context, gem: gem, energy: energy)
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
        for (gemID, gemEnergy) in context.gemEnergy {
            if gemEnergy.releaseTime > context.currentTime {
                continue
            }
            for energy in gemEnergy.energy {
                let gem = context.spell.gems.first(where: {$0.id == gemID})!
                let created = split(pattern: pattern, energy: energy, gem: gem)
                newEnergy.append(contentsOf: created)
                context.gemEnergy[gemID] = nil
            }
        }
        
        for i in removedIndexes.reversed() {
            context.energy.remove(at: i)
        }
        context.energy.append(contentsOf: newEnergy)
    }
    
    private func applyDrag(energy: inout SpellEnergy, force: ForceComponents, delta: Float) {
        energy.velocity = energy.velocity.drag(direction: force.towardsLine, pct: 1 * delta)
    }
    
    private func split(pattern: PatternProtocol, energy: SpellEnergy, gem: GemPosition) -> [SpellEnergy] {
        let splits = gem.gem.shape.splits
        let gemPosition = pattern.position(time: gem.time)
        
        return splits.map { split in
            let vel = energy.velocity.rotated(by: split.angle)
            let pos = gemPosition + split.outputPosition * gem.gem.size.x * 0.5
            
            return SpellEnergy(
                gemIDs: energy.gemIDs,
                time: energy.time,
                position: pos,
                velocity: vel,
                power: energy.power/2,
                energyDistribution: [gem.gem.type: 1]
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
    
    private func charge(context: inout SpellContext, gem: GemPosition, energy: SpellEnergy) {
        var energy = energy
        energy.gemIDs.insert(gem.id)
        var gemEnergy = context.gemEnergy[gem.id] ?? .empty(context: context)
        gemEnergy.energy.append(energy)
        gemEnergy.releaseTime = context.currentTime + 0.3
        context.gemEnergy[gem.id] = gemEnergy
    }
    
    func result(context: SpellContext) -> CastResult {
        var power: Float = 0
        var maxDistance: Float = 0
        let pattern = context.spell.pattern
        var velocitySum = Vector2(0, 0)
        for energy in context.energy {
            power += energy.power
            let distance = (energy.position - pattern.position(time: 1)).length
            maxDistance = max(distance, maxDistance)
            let absVelocity = Vector2(abs(energy.velocity.x), energy.velocity.y)
            velocitySum += absVelocity * energy.power
        }
        
        let shape = shapeMatcher.bestMatch(points: context.energy.map { $0.position })
        let target: SpellTarget = velocitySum.x >= 0.75 * velocitySum.y ? .caster : .enemy
        
        return .init(
            energy: context.energy,
            shape: shape,
            target: target,
            power: power,
            deviance: maxDistance,
            velocitySum: velocitySum
        )
    }
    
}
