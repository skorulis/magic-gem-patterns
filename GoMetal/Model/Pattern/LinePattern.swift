//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import VectorMath

struct LinePattern: PatternProtocol {
    func position(time: CGFloat) -> CGPoint {
        let y = -1 + time * 2
        return .init(x: 0, y: y)
    }
    
    func force(at point: CGPoint) -> Vector2 {
        let lf = lineForce(x: Float(point.x))
        let ef = endForce(point: point)
        return lf + ef
    }
    
    private func endForce(point: CGPoint) -> Vector2 {
        let end = Vector2(0, 1)
        let p = Vector2(point)
        return (end - p).normalized() * 0.25
    }
    
    private func lineForce(x: Float) -> Vector2 {
        if x == 0 { return .zero }
        let xDistance = abs(x)
        let xPower = pow(1 - xDistance, 2)
        let xDirection: Float = x > 0 ? -1 : 1
        return .init(xPower * xDirection, 0)
    }
    
    
}
