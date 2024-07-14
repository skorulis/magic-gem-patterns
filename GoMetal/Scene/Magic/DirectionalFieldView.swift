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
        let force = pattern.force(at: point, size: size)
        var path = Path()
        path.move(to: point)
        path.addLine(to: .init(x: point.x + force.width, y: point.y + force.height))
        context.stroke(path, with: .color(.green), lineWidth: 2)
    }
}
