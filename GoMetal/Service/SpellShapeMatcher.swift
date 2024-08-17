//  Created by Alexander Skorulis on 16/8/2024.

import Foundation
import VectorMath

struct SpellShapeMatcher {
    
    let availableShapes: [SpellShape] = [.beam, .ball]
    
    func bestMatch(points: [Vector2]) -> SpellShape {
        if points.count <= 1 {
            return .bolt
        }
        var context = Context(points: points)
        var bestScore: Float = -.greatestFiniteMagnitude
        var bestShape: SpellShape = .bolt
        for shape in availableShapes {
            let score = -deviance(shape: shape, context: &context)
            if score > bestScore {
                bestScore = score
                bestShape = shape
            }
        }
        
        return bestShape
    }

    
    func deviance(shape: SpellShape, context: inout Context) -> Float {
        switch shape {
        case .bolt:
            return -1
        case .beam:
            return lineDeviance(context: &context)
        case .ball:
            return circleDeviance(context: &context)
        case .wave:
            return -1
        }
    }
    
    private func lineDeviance(context: inout Context) -> Float {
        var total: Float = 0
        for p in context.points {
            total += abs(p.x - context.center.x)
        }
        
        return total
    }
    
    private func circleDeviance(context: inout Context) -> Float {
        let r = context.maxDistance
        var total: Float = 0
        for p in context.points {
            let distance = (p - context.center).length
            total += abs(r - distance)
        }
        return total
    }
    
    struct Context {
        let points: [Vector2]
        
        lazy var center = Vector2.center(points: points)
        lazy var bounds = Vector2.bounds(points: points)
        lazy var maxDistance: Float = {
            let distances = points.map { ($0 - center).length }
            return distances.max() ?? 0
        }()
    }
}
