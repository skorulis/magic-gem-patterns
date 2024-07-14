//  Created by Alexander Skorulis on 14/7/2024.

import Foundation

// A Spell pattern inside a normalised card with a -1...1 range in the X and Y direction.
protocol PatternProtocol {
    func position(time: CGFloat) -> CGPoint
    func force(at point: CGPoint) -> CGSize
}

struct ScreenPattern {
    let space: PatternSpace
    let pattern: PatternProtocol
    
    init(pattern: PatternProtocol, canvasSize: CGSize) {
        self.pattern = pattern
        self.space = .init(canvasSize: canvasSize)
    }
    
    func position(time: CGFloat) -> CGPoint {
        let pos = pattern.position(time: time)
        return space.toScreenSpace(point: pos)
    }
    
    // Return the force in screen coordinates
    func force(at point: CGPoint) -> CGSize {
        let normalisedForce = pattern.force(at: space.toPatternSpace(point: point))
        return space.toScreenSpace(size: normalisedForce)
    }
}
