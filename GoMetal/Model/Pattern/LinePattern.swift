//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import VectorMath
import SwiftUI

struct LinePattern: PatternProtocol {
    func position(time: Float) -> Vector2 {
        let y = -1 + time * 2
        return .init(0, Float(y))
    }
    
    func time(position: Vector2) -> Float {
        return (position.y + 1) / 2
    }
    
    func force(at point: Vector2) -> Vector2 {
        let lf = lineForce(at: point)
        let ef = endForce(point: point)
        return lf + ef
    }
    
    func endForce(point: Vector2) -> Vector2 {
        return .init(0, 1) * 0.5
    }
    
    func lineForce(at: Vector2) -> Vector2 {
        let x = at.x
        if x == 0 { return .zero }
        let xDistance = abs(x)
        let xPower = pow(1 - xDistance, 2)
        let xDirection: Float = x > 0 ? -1 : 1
        return .init(xPower * xDirection, 0)
    }
    
    func closestPoint(to: Vector2) -> Vector2 {
        let y = max(min(to.y, 1), -1)
        return .init(0, y)
    }
    
    func forwardsDirection(at: Vector2) -> Vector2 {
        return .init(0, 1)
    }
    
    var shape: any Shape {
        return LinePatternShape()
    }
    
}

struct LinePatternShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.midX, y: rect.maxY))
        path.addLine(to: .init(x: rect.midX, y: rect.minY))
        return path
    }
}
