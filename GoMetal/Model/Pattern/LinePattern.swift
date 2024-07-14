//  Created by Alexander Skorulis on 14/7/2024.

import Foundation

struct LinePattern: PatternProtocol {
    func position(time: CGFloat) -> CGPoint {
        let y = -1 + time * 2
        return .init(x: 0, y: y)
    }
    
    func force(at point: CGPoint) -> CGSize {
        let lf = lineForce(x: point.x)
        let ef = endForce(point: point)
        return .init(width: lf.width + ef.width, height: lf.height + ef.height)
    }
    
    private func endForce(point: CGPoint) -> CGSize {
        let end = CGPoint(x: 0, y: 1)
        let dir = CGPoint(x: end.x - point.x, y: end.y - point.y)
        
        return .init(width: dir.x, height: dir.y)
    }
    
    private func lineForce(x: CGFloat) -> CGSize {
        if x == 0 { return .zero }
        let xDistance = abs(x)
        let xPower = pow(1 - xDistance, 2)
        let xDirection: CGFloat = x > 0 ? -1 : 1
        return .init(width: xPower * xDirection, height: 0)
    }
    
    
}
