//  Created by Alexander Skorulis on 13/8/2024.

import Foundation
import VectorMath

extension Vector2 {
    static func + (lhs: Vector2, rhs: Vector2) -> Vector2 {
        return .init(lhs.x + rhs.x, lhs.y + rhs.y)
    }
    
    static func += (lhs: inout Vector2, rhs: Vector2) {
        lhs = lhs + rhs
    }
    
    static func - (lhs: Vector2, rhs: Vector2) -> Vector2 {
        return .init(lhs.x - rhs.x, lhs.y - rhs.y)
    }
    
    static func -= (lhs: inout Vector2, rhs: Vector2) {
        lhs = lhs - rhs
    }
    
    static func * (lhs: Vector2, rhs: Float) -> Vector2 {
        .init(lhs.x * rhs, lhs.y * rhs)
    }
    
    static func *= (lhs: inout Vector2, rhs: Float) {
        lhs = lhs * rhs
    }
    
    init(_ point: CGPoint) {
        self.init(Float(point.x), Float(point.y))
    }
    
    init(_ size: CGSize) {
        self.init(Float(size.width), Float(size.height))
    }
    
    /// Prevent the length being over a given value
    func clamped(_ length: Float) -> Vector2 {
        let l = self.length
        if l <= length {
            return self
        }
        let div = l / length
        return .init(x/div, y/div)
    }
    
    func viewOffset(_ viewSize: CGSize) -> CGSize {
        .init(width: CGFloat(x) - viewSize.width/2, height: CGFloat(y) - viewSize.height/2)
    }
    
    func cleaned(_ minValue: Float = 0.000001) -> Self {
        let x = abs(x) < minValue ? 0 : x
        let y = abs(y) < minValue ? 0 : y
        return .init(x, y)
    }
    
    // Given a unit vector direction, apply drag without affecting the perpendicular direction
    func drag(direction: Vector2, pct: Float) -> Vector2 {
        let unitDirection = direction.normalized()
        let vectorInDragDirection = unitDirection * self.dot(unitDirection)
        let draggedComponent = vectorInDragDirection * (1 - pct)
        return draggedComponent + (self - vectorInDragDirection)
    }
}