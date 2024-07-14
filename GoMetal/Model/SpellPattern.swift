//  Created by Alexander Skorulis on 10/7/2024.

import Foundation

enum SpellPattern: String, CaseIterable, Identifiable {
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
    
    var basePower: CGFloat {
        return 20
    }
    
    // Rate at which the spell returns to normal
    var normalisation: CGFloat {
        return 0.5 // Normalise in half the time
    }
}
