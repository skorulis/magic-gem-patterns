//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import VectorMath

struct Spell: Equatable, Hashable, Identifiable, Codable {
    
    let id: UUID
    var name: String
    
    // The pattern this spell is built on
    var patternType: SpellPattern
    
    var pattern: PatternProtocol {
        patternType.pattern
    }
    
    // Where the gems are placed
    var gems: [GemPosition]
    
    static func blank() -> Spell {
        .init(id: UUID(), name: "New Spell", patternType: .line, gems: [])
    }
}

struct GemPosition: Equatable, Hashable, Identifiable, Codable {
    let id = UUID()
    let gem: Gem
    var time: Float
}
