//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import VectorMath

enum Math {
    static func polarToCartesian(r: CGFloat, theta: CGFloat) -> CGSize {
        let x = r * cos(theta)
        let y = r * sin(theta)
        return .init(width: x, height: y)
    }
    
    static func cartesianToPolar(x: Double, y: Double) -> (r: Double, theta: Double) {
        let r = sqrt(x * x + y * y)
        let theta = atan2(y, x)
        return (r, theta)
    }
}

extension Vector2 {
    static func * (lhs: Vector2, rhs: Float) -> Vector2 {
        .init(lhs.x * rhs, lhs.y * rhs)
    }
    
    init(_ point: CGPoint) {
        self.init(Float(point.x), Float(point.y))
    }
}
