//  Created by Alexander Skorulis on 10/7/2024.

import Foundation

final class SpellCastService {
    
    func update(context: inout SpellContext, delta: Float) {
        var energy = context.energy
        let pattern = context.spell.pattern.pattern
        let force = pattern.force(at: energy.position)
        energy.position += (energy.velocity * delta)
        energy.velocity += (force * delta)
        context.energy = energy
    }
    
}
