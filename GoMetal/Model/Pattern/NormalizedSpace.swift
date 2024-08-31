//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import VectorMath

// Space normalised into a -1...1 square.
struct NormalizedSpace {
    
    let canvasSize: CGSize
    
    func toNormalSpace(point: Vector2) -> Vector2 {
        return Self.toNormalSpace(point: point, size: canvasSize)
    }
    
    func toScreenSpace(point: Vector2) -> Vector2 {
        return Self.toScreenSpace(point: point, size: canvasSize)
    }
    
    func toScreenSpace(size: Vector2) -> Vector2 {
        return Self.toScreenSpace(size: size, screenSize: canvasSize)
    }
    
    static func toNormalSpace(point: Vector2, size: CGSize) -> Vector2 {
        let x = 2 * point.x / Float(size.width) - 1
        let y = -2 * point.y / Float(size.height) + 1
        return .init(x, y)
    }
    
    static func toScreenSpace(point: Vector2, size: CGSize) -> Vector2 {
        let x = (point.x + 1)/2 * Float(size.width)
        let y = (point.y - 1)/2 * -Float(size.height)
        return .init(x, y)
    }
    
    static func toScreenSpace(size: Vector2, screenSize: CGSize) -> Vector2 {
        let width = Float(screenSize.width) * size.x / 2
        let height = -Float(screenSize.height) * size.y / 2
        return .init(width, height)
    }

}
