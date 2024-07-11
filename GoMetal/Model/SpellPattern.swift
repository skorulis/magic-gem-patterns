//  Created by Alexander Skorulis on 10/7/2024.

import Foundation

enum SpellPattern {
    case circle
    case line
    
    // The position relative to the centre of the pattern
    // time is between 0 and 1
    func position(time: CGFloat, size: CGSize) -> CGSize {
        switch self {
        case .circle:
            let theta = time * .pi * 2
            let r = size.width / 2
            return Math.polarToCartesian(r: r, theta: theta)
        case .line:
            let y = size.height * (1 - time) - size.height / 2
            return .init(width: 0, height: y)
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
