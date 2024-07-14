//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import VectorMath

// Patterns are normalised into a -1...1 square.
struct PatternSpace {
    
    let canvasSize: CGSize
    
    func toPatternSpace(point: CGPoint) -> CGPoint {
        return Self.toPatternSpace(point: point, size: canvasSize)
    }
    
    func toScreenSpace(point: CGPoint) -> CGPoint {
        return Self.toScreenSpace(point: point, size: canvasSize)
    }
    
    func toScreenSpace(size: Vector2) -> Vector2 {
        return Self.toScreenSpace(size: size, screenSize: canvasSize)
    }
    
    static func toPatternSpace(point: CGPoint, size: CGSize) -> CGPoint {
        let x = 2 * point.x / size.width - 1
        let y = -2 * point.y / size.height + 1
        return .init(x: x, y: y)
    }
    
    static func toScreenSpace(point: CGPoint, size: CGSize) -> CGPoint {
        let x = (point.x + 1)/2 * size.width
        let y = (point.y - 1)/2 * -size.height
        return .init(x: x, y: y)
    }
    
    static func toScreenSpace(size: Vector2, screenSize: CGSize) -> Vector2 {
        let width = Float(screenSize.width) * size.x / 2
        let height = -Float(screenSize.height) * size.y / 2
        return .init(width, height)
    }

}
