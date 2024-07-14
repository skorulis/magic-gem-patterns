//  Created by Alexander Skorulis on 11/7/2024.


import SwiftUI

struct DirectionalFieldView: View {
    
    let pattern: SpellPattern
    let canvasSize: CGSize
    let spacing: CGFloat = 24
    
    var body: some View {
        Canvas { context, size in
            for y in stride(from: 0, to: size.height, by: spacing) {
                for x in stride(from: 0, to: size.width, by: spacing) {
                    addFlow(context: context, point: .init(x: x, y: y), size: size)
                }
            }
        }
    }
    
    private func addFlow(context: GraphicsContext, point: CGPoint, size: CGSize) {
        let force = screenPattern.force(at: point)
        var path = Path()
        path.move(to: point)
        let forceX = max(min(force.width, spacing / 2), -spacing / 2)
        let forceY = max(min(force.height, spacing / 2), -spacing / 2)
        path.addLine(to: .init(x: point.x + forceX, y: point.y + forceY))
        context.stroke(path, with: .color(.green), lineWidth: 2)
    }
    
    var screenPattern: ScreenPattern {
        return .init(pattern: pattern.pattern, canvasSize: canvasSize)
    }
}
