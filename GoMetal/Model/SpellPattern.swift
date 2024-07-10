//  Created by Alexander Skorulis on 10/7/2024.

import Foundation

enum SpellPattern {
    case circle
    
    // The position relative to the centre of the pattern
    func position(time: CGFloat, size: CGSize) -> CGSize {
        let theta = time * .pi * 2
        let r = size.width / 2
        let size = Math.polarToCartesian(r: r, theta: theta)
        return size
    }
    
    var basePower: CGFloat {
        return 20
    }
    
    // Rate at which the spell returns to normal
    var normalisation: CGFloat {
        return 0.5 // Normalise in half the time
    }
}
