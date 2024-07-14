//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import VectorMath

struct CirclePattern: PatternProtocol {
    func position(time: CGFloat) -> Vector2 {
        let theta = time * .pi * 2
        return Math.polarToCartesian(r: 1, theta: Float(theta))
    }
    
    func force(at point: Vector2) -> Vector2 {
        .zero
    }
    
    func closestPoint(to: Vector2) -> Vector2 {
        let angle = Math.cartesianToPolar(x: to.x, y: to.y).theta
        return Math.polarToCartesian(r: 1, theta: angle)
    }
    
}
