//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import VectorMath

struct LinePattern: PatternProtocol {
    func position(time: CGFloat) -> Vector2 {
        let y = -1 + time * 2
        return .init(0, Float(y))
    }
    
    func force(at point: Vector2) -> Vector2 {
        let lf = lineForce(x: Float(point.x))
        let ef = endForce(point: point)
        return lf + ef
    }
    
    private func endForce(point: Vector2) -> Vector2 {
        let end = Vector2(0, 1)
        return (end - point).normalized() * 0.25
    }
    
    private func lineForce(x: Float) -> Vector2 {
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
    
}
