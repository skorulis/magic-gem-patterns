//  Created by Alexander Skorulis on 10/7/2024.

import Foundation

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
