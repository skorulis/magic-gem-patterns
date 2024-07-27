//  Created by Alexander Skorulis on 19/7/2024.

import Foundation

@Observable final class MainStore {
    
    var spell: Spell = .init(
        patternType: .line,
        gems: [
            .init(gem: .baseDiamond, time: 0.25),
            .init(gem: .baseHexagon, time: 0.75)
        ]
    )
    
    var spellContext: SpellContext?
}
