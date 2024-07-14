//  Created by Alexander Skorulis on 10/7/2024.

import Foundation

struct Spell {
    // The pattern this spell is built on
    var pattern: SpellPattern
    
    // Where the gems are placed
    var gems: [GemPosition]
}

struct GemPosition {
    var time: Float
}
