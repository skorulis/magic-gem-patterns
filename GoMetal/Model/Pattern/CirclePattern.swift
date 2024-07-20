//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import VectorMath
import SwiftUI

struct CirclePattern: PatternProtocol {
    func position(time: Float) -> Vector2 {
        let theta = time * .pi * 2
        return Math.polarToCartesian(r: 1, theta: Float(theta))
    }
    
    func time(position: Vector2) -> Float {
        let polar = Math.cartesianToPolar(x: position.x, y: position.y)
        return polar.theta / (2 * .pi)
    }
    
    func closestPoint(to: Vector2) -> Vector2 {
        let angle = Math.cartesianToPolar(x: to.x, y: to.y).theta
        return Math.polarToCartesian(r: 1, theta: angle)
    }
    
    func force(at point: Vector2) -> Vector2 {
        return lineForce(point: point) + endForce(point: point)
    }
    
    func lineForce(point: Vector2) -> Vector2 {
        let centerDist = point.length
        if centerDist == 1 {
            return .zero
        } else if centerDist > 1 {
            let overshoot = centerDist - 1
            let power = max(1 - overshoot, 0)
            return point.normalized() * pow(power, 2)
        } else {
            return point.normalized() * pow(centerDist, 2)
        }
    }
    
    func endForce(point: Vector2) -> Vector2 {
        if point == .zero {
            return .zero
        }
        let onLine = closestPoint(to: point)
        return onLine.rotated(by: .halfPi).normalized()
    }
    
    func forwardsDirection(at: Vector2) -> Vector2 {
        // TODO: Confirm this is correct
        return endForce(point: at)
    }
    
    var shape: any Shape {
        return Circle()
    }
}
