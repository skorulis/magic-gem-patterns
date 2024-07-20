//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import VectorMath

struct Spell {
    // The pattern this spell is built on
    var patternType: SpellPattern
    
    var pattern: PatternProtocol {
        patternType.pattern
    }
    
    // Where the gems are placed
    var gems: [GemPosition]
}

enum Gem {
    case square
    
    var size: Vector2 { .init(0.2, 0.2) }
}

struct GemPosition: Identifiable {
    let id = UUID()
    let gem: Gem
    var time: Float
}
