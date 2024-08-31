//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import VectorMath
import SwiftUI

// A Spell pattern inside a normalised card with a -1...1 range in the X and Y direction.
protocol PatternProtocol {
    // Return the position on the pattern line for the given time
    func position(time: Float) -> Vector2
    
    // Return the energy directional force at a given point
    func force(at point: Vector2) -> ForceComponents
    
    // Return the closest point on the line to the given point
    func closestPoint(to: Vector2) -> Vector2
    
    // Return the time that corresponds to the given point
    func time(position: Vector2) -> Float
    
    // The forward direction of the pattern at this point
    func forwardsDirection(at: Vector2) -> Vector2
    
    var shape: any Shape { get }
}

extension PatternProtocol {
    func forceTowardsLine(at point: Vector2) -> Vector2 {
        let linePoint = closestPoint(to: point)
        let dir = (linePoint - point)
        let dist = max(dir.length, 0.4)
        let power = 1 / (dist * dist)
        return dir.normalized() * power
    }
}

struct ScreenPattern {
    let space: NormalizedSpace
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
    func force(at point: Vector2) -> ForceComponents {
        let f = pattern.force(at: space.toNormalSpace(point: point))
        let ss = CGSize(width: 2, height: 2)
        return .init(
            towardsEnd: NormalizedSpace.toScreenSpace(size: f.towardsEnd, screenSize: ss),
            towardsLine: NormalizedSpace.toScreenSpace(size: f.towardsLine, screenSize: ss)
        )
    }
    
    func closestPoint(to: Vector2) -> Vector2 {
        let patternPoint = space.toNormalSpace(point: to)
        let result = pattern.closestPoint(to: patternPoint)
        return space.toScreenSpace(point: result)
    }
    
    func time(position: Vector2) -> Float {
        let patternPoint = space.toNormalSpace(point: position)
        return pattern.time(position: patternPoint)
    }
}
