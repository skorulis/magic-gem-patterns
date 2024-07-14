//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import VectorMath

// A Spell pattern inside a normalised card with a -1...1 range in the X and Y direction.
protocol PatternProtocol {
    func position(time: CGFloat) -> Vector2
    func force(at point: Vector2) -> Vector2
    func closestPoint(to: Vector2) -> Vector2
}

struct ScreenPattern {
    let space: PatternSpace
    let pattern: PatternProtocol
    
    init(pattern: PatternProtocol, canvasSize: CGSize) {
        self.pattern = pattern
        self.space = .init(canvasSize: canvasSize)
    }
    
    func position(time: CGFloat) -> Vector2 {
        let pos = pattern.position(time: time)
        return space.toScreenSpace(point: pos)
    }
    
    // Return the force in screen coordinates
    func force(at point: Vector2) -> Vector2 {
        let normalisedForce = pattern.force(at: space.toPatternSpace(point: point))
        return space.toScreenSpace(size: normalisedForce)
    }
    
    func closestPoint(to: Vector2) -> Vector2 {
        let patternPoint = space.toPatternSpace(point: to)
        let result = pattern.closestPoint(to: patternPoint)
        return space.toScreenSpace(point: result)
    }
}
