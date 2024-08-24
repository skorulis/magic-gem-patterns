//  Created by Alexander Skorulis on 10/7/2024.

import Foundation

enum SpellPattern: String, CaseIterable, Equatable, Hashable, Identifiable, Codable {
    case circle
    case line
    
    var id: String { rawValue }
    
    var pattern: PatternProtocol {
        switch self {
        case .circle:
            return CirclePattern()
        case .line:
            return LinePattern()
        }
    }
    
    var basePower: Float {
        return 20
    }
    
    // Rate at which the spell returns to normal
    var normalisation: Float {
        return 0.5 // Normalise in half the time
    }
}
