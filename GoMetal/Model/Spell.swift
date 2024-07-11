//  Created by Alexander Skorulis on 10/7/2024.

import Foundation

struct Spell {
    // The pattern this spell is built on
    let pattern: SpellPattern
    
    // Where the gems are placed
    let gems: [GemPosition]
}

struct GemPosition {
    let time: TimeInterval
}
