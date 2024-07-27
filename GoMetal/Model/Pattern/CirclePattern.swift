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
        let t = polar.theta / (2 * .pi)
        if t < 0 {
            return 1 + t
        } else {
            return t
        }
    }
    
    func closestPoint(to: Vector2) -> Vector2 {
        let angle = Math.cartesianToPolar(x: to.x, y: to.y).theta
        return Math.polarToCartesian(r: 1, theta: angle)
    }
    
    func force(at point: Vector2) -> ForceComponents {
        return .init(
            towardsEnd: endForce(point: point),
            towardsLine: forceTowardsLine(at: point)
        )
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
        return CirclePatternShape()
    }
}

struct CirclePatternShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.maxX, y: rect.midY))
        path.addArc(
            center: .init(x: rect.midX, y: rect.midY),
            radius: rect.midX,
            startAngle: .zero,
            endAngle: .radians(.pi * 2),
            clockwise: true
        )
        return path
    }
}
