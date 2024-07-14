//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI

struct PatternDisplayView: View {
    
    let pattern: SpellPattern
    let canvasSize: CGSize
    @State private var rotation: CGFloat = 0
    @GestureState private var dragAmount: CGSize = .zero
    
    var body: some View {
        ZStack {
            AnyShape(pattern.shape)
                .stroke(style: StrokeStyle(lineWidth: 4))
                .foregroundColor(.blue)
            handle
        }
        .contentShape(Rectangle())
        .gesture(dragGesture)
    }
    
    private var handle: some View {
        GemView()
            .offset(handleOffset(translation: dragAmount))
    }
    
    private func handleAngle(translation: CGSize) -> CGFloat {
        let orig = originalHandleOffset
        let draggedTo = CGSize(
            width: orig.width + translation.width,
            height: orig.height + translation.height
        )
        return Math.cartesianToPolar(x: draggedTo.width, y: draggedTo.height).theta
    }
    
    private func handleOffset(translation: CGSize) -> CGSize {
        let angle = handleAngle(translation: translation)
        return Math.polarToCartesian(r: canvasSize.width/2, theta: angle)
    }
    
    private var originalHandleOffset: CGSize {
        return Math.polarToCartesian(r: canvasSize.width/2, theta: rotation)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($dragAmount) { value, state, transaction in
                state = value.translation
            }
            .onEnded { drag in
                self.rotation = handleAngle(translation: drag.translation)
            }
    }
}

extension SpellPattern {
    var shape: any Shape {
        switch self {
        case .circle:
            return Circle()
        case .line:
            return LinePatternShape()
        }
    }
}

struct LinePatternShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.midX, y: rect.maxY))
        path.addLine(to: .init(x: rect.midX, y: rect.minY))
        return path
    }
    
    
}
