//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import VectorMath
import SwiftUI

// A Spell pattern inside a normalised card with a -1...1 range in the X and Y direction.
protocol PatternProtocol {
    // Return the position on the pattern line for the given time
    func position(time: Float) -> Vector2
    
    // Return the energy directional force at a given point
    func force(at point: Vector2) -> Vector2
    
    // Return the closest point on the line to the given point
    func closestPoint(to: Vector2) -> Vector2
    
    // Return the time that corresponds to the given point
    func time(position: Vector2) -> Float
    
    var shape: any Shape { get }
}

struct ScreenPattern {
    let space: PatternSpace
    let pattern: PatternProtocol
    
    init(pattern: PatternProtocol, canvasSize: CGSize) {
        self.pattern = pattern
        self.space = .init(canvasSize: canvasSize)
    }
    
    func position(time: Float) -> Vector2 {
        let pos = pattern.position(time: time)
        return space.toScreenSpace(point: pos)
    }
    
    // Return the force in screen coordinates
    func force(at point: Vector2) -> Vector2 {
        let f = pattern.force(at: space.toPatternSpace(point: point))
        return PatternSpace.toScreenSpace(size: f, screenSize: .init(width: 2, height: 2))
    }
    
    func closestPoint(to: Vector2) -> Vector2 {
        let patternPoint = space.toPatternSpace(point: to)
        let result = pattern.closestPoint(to: patternPoint)
        return space.toScreenSpace(point: result)
    }
    
    func time(position: Vector2) -> Float {
        let patternPoint = space.toPatternSpace(point: position)
        return pattern.time(position: patternPoint)
    }
}
