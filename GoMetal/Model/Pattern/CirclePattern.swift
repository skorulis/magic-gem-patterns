//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import VectorMath

struct CirclePattern: PatternProtocol {
    func position(time: CGFloat) -> CGPoint {
        let theta = time * .pi * 2
        let size =  Math.polarToCartesian(r: 1, theta: theta)
        return .init(x: size.width, y: size.height)
    }
    
    func force(at point: CGPoint) -> Vector2 {
        .zero
    }
    
    func closestPoint(to: CGPoint) -> CGPoint {
        let angle = Math.cartesianToPolar(x: to.x, y: to.y).theta
        let size = Math.polarToCartesian(r: 1, theta: angle)
        return .init(x: size.width, y: size.height)
    }
    
}
