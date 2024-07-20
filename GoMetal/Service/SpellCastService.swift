//  Created by Alexander Skorulis on 10/7/2024.

import Foundation

final class SpellCastService {
    
    func update(context: inout SpellContext, delta: Float) {
        let pattern = context.spell.pattern.pattern
        for (i, var energy) in context.energy.enumerated() {
            let force = pattern.force(at: energy.position)
            energy.position += (energy.velocity * delta)
            energy.velocity += (force * delta)
            context.energy[i] = energy
            
            let t = pattern.time(position: energy.position)
            context.completeness = max(context.completeness, t)
        }
    }
    
}
