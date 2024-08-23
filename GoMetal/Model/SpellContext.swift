//  Created by Alexander Skorulis on 15/7/2024.

import Foundation

struct SpellContext {
    let spell: Spell
    let startTime: Date
    var currentTime: Float
    var energy: [SpellEnergy]
    var completeness: Float
    var gemEnergy: [Gem.ID: GemEnergy]
    
    init(
        spell: Spell,
        startTime: Date,
        energy: [SpellEnergy]
    ) {
        self.spell = spell
        self.startTime = startTime
        self.currentTime = 0
        self.energy = energy
        self.completeness = 0
        self.gemEnergy = [:]
    }
    
}

extension SpellContext {
    struct GemEnergy {
        var energy: [SpellEnergy]
        var releaseTime: Float
        
        static func empty(context: SpellContext) -> GemEnergy {
            GemEnergy(energy: [], releaseTime: context.currentTime + 0.2)
        }
    }
}
