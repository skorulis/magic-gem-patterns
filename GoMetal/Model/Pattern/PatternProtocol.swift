//  Created by Alexander Skorulis on 14/7/2024.

import Foundation

// A Spell pattern inside a normalised card with a -1...1 range in the X and Y direction.
protocol PatternProtocol {
    func position(time: CGFloat) -> CGPoint
    func force(at point: CGPoint) -> CGSize
}

