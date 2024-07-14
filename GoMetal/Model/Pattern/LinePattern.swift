//  Created by Alexander Skorulis on 14/7/2024.

import Foundation

struct LinePattern: PatternProtocol {
    func position(time: CGFloat) -> CGPoint {
        let y = -1 + time * 2
        return .init(x: 0, y: y)
    }
    
    func force(at point: CGPoint) -> CGSize {
        .init(width: 0.005, height: 0.005)
    }
    
    
}
