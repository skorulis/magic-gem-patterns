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
        let force = screenPattern.force(at: .init(point))
        var path = Path()
        path.move(to: point)
        
        let s = Float(spacing)
        let normalForce = (force * s).clamped(s)
        let forceX = CGFloat(normalForce.x)
        let forceY = CGFloat(normalForce.y)
        path.addLine(to: .init(x: point.x + forceX, y: point.y + forceY))
        let color: Color = forceX > 0 ? .red : .blue
        context.stroke(path, with: .color(color), lineWidth: 2)
    }
    
    var screenPattern: ScreenPattern {
        return .init(pattern: pattern.pattern, canvasSize: canvasSize)
    }
}
