//  Created by Alexander Skorulis on 11/7/2024.


import SwiftUI
import VectorMath

struct DirectionalFieldView: View {
    
    let pattern: PatternProtocol
    let canvasSize: CGSize
    let spacing: CGFloat = 24
    let forceType: ForceType
    
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
        let p1 = Vector2(point)
        let force = forceType.force(components: screenPattern.force(at: p1))
        var path = Path()
        path.move(to: point)
        
        let s = Float(spacing / 2)
        let normalForce = (force * s).clamped(s)
        let endPos = p1 + normalForce
        
        path.addLine(to: CGPoint(endPos))
        
        let arrowLength: Float = 3
        let arrowLeft = normalForce.rotated(by: 0.8 * .pi).normalized() * 3
        let arrowRight = normalForce.rotated(by: -0.8 * .pi).normalized() * 3
        path.addLine(to: CGPoint(endPos + arrowLeft))
        path.move(to: CGPoint(endPos))
        path.addLine(to: CGPoint(endPos + arrowRight))
        
        context.stroke(path, with: .color(color(dir: normalForce)), lineWidth: 2)
    }
    
    private func color(dir: Vector2) -> Color {
        let xC: UIColor = dir.x > 0 ? .red : .blue
        let yC: UIColor = dir.y > 0 ? .green : .green
        let total = (abs(dir.x) + abs(dir.y))
        let xI = abs(dir.x) / total
        let yI = abs(dir.y) / total
        let blended = UIColor.blend(color1: xC, intensity1: CGFloat(xI), color2: yC, intensity2: CGFloat(yI))
        return Color(blended)
    }
    
    var screenPattern: ScreenPattern {
        return .init(pattern: pattern, canvasSize: canvasSize)
    }
}

extension DirectionalFieldView {
    enum ForceType {
        case all, toEnd, toLine
        
        func force(components: ForceComponents) -> Vector2 {
            switch self {
            case .all:
                return components.total
            case .toEnd:
                return components.towardsEnd
            case .toLine:
                return components.towardsLine
            }
        }
    }
}

extension UIColor {
    static func blend(color1: UIColor, intensity1: CGFloat = 0.5, color2: UIColor, intensity2: CGFloat = 0.5) -> UIColor {
        let total = intensity1 + intensity2
        let l1 = intensity1/total
        let l2 = intensity2/total
        guard l1 > 0 else { return color2}
        guard l2 > 0 else { return color1}
        var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)

        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        return UIColor(red: l1*r1 + l2*r2, green: l1*g1 + l2*g2, blue: l1*b1 + l2*b2, alpha: l1*a1 + l2*a2)
    }
}
