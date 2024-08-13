//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import VectorMath

enum Math {
    static func polarToCartesian(r: Float, theta: Float) -> Vector2 {
        let x = r * cos(theta)
        let y = r * sin(theta)
        return .init(x, y)
    }
    
    static func cartesianToPolar(x: Float, y: Float) -> (r: Float, theta: Float) {
        let r = sqrt(x * x + y * y)
        let theta = atan2(y, x)
        return (r, theta)
    }
}

