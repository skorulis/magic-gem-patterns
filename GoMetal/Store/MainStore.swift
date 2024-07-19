//  Created by Alexander Skorulis on 19/7/2024.

import Foundation

@Observable final class MainStore {
    
    var spell: Spell = .init(
        pattern: .line,
        gems: [.init(time: 0.5)]
    )
    
    var spellContext: SpellContext?
}
