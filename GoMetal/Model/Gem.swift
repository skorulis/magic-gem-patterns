//  Created by Alexander Skorulis on 27/7/2024.

import SwiftUI
import VectorMath

struct Gem: Equatable, Hashable, Identifiable, Codable {

    let id: UUID
    let shape: GemShape
    let type: EnergyType
    var size: Vector2 { .init(0.2, 0.2) }
    
    init(id: UUID = UUID(), shape: GemShape, type: EnergyType) {
        self.id = id
        self.shape = shape
        self.type = type
    }
    
    static var baseDiamond: Self { .init(shape: .diamond, type: .fire) }
    static var baseHexagon: Self { .init(shape: .hexagon, type: .water) }
    static var baseSquare: Self { .init(shape: .square, type: .raw) }
    
}

enum GemShape: Codable {
    case diamond
    case hexagon
    case square
    
    var displayShape: AnyShape {
        switch self {
        case .diamond:
            return AnyShape(Polygon(numberOfSides: 4))
        case .hexagon:
            return AnyShape(Polygon(numberOfSides: 6))
        case .square:
            return AnyShape(Rectangle())
        }
    }
    
    var splits: [GemSplit] {
        switch self {
        case .diamond:
            return [
                .init(
                    angle: -.pi/4,
                    outputPosition: .init(0.5, 0.5)
                ),
                .init(
                    angle: .pi/4,
                    outputPosition: .init(-0.5, 0.5)
                ),
            ]
        case .hexagon:
            return [
                .init(
                    angle: -.pi/6,
                    outputPosition: .init(0.75, 0.5)
                ),
                .init(
                    angle: 0,
                    outputPosition: .init(0, 1)
                ),
                .init(
                    angle: .pi/6,
                    outputPosition: .init(-0.75, 0.5)
                ),
            ]
        case .square:
            return [
                .init(
                    angle: -.pi/2,
                    outputPosition: .init(1, 0)
                ),
                .init(
                    angle: .pi/2,
                    outputPosition: .init(-1, 0)
                ),
            ]
        }
    }
}

public struct GemSplit {
    let angle: Float
    let outputPosition: Vector2
}

public struct Polygon: Shape {
    /// number of equal sides
    public let numberOfSides: Int
    public let rotationAngle: Angle = .zero
    
    public func path(in rect: CGRect) -> Path {
        let centerPoint = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2.0
        
        let angleSliceFromCenter = 2 * .pi / CGFloat(numberOfSides)

        // iterate over the sides of the polygon and collect each point on the circle
        // where the polygon corner should be
        var polygonPath = Path()
        for i in 0..<numberOfSides {
          let currentAngleFromCenter = CGFloat(i) * angleSliceFromCenter
          let rotatedAngleFromCenter = currentAngleFromCenter + rotationAngle.radians
          let x = centerPoint.x + radius * cos(rotatedAngleFromCenter)
          let y = centerPoint.y + radius * sin(rotatedAngleFromCenter)
          if i == 0 {
            polygonPath.move(to: CGPoint(x: x, y: y))
          } else {
            polygonPath.addLine(to: CGPoint(x: x, y: y))
          }
        }
        polygonPath.closeSubpath()
        return polygonPath
    }
}
