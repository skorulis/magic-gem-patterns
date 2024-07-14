//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI
import VectorMath

struct GemPositionEditView: View {
    
    @Binding var spell: Spell
    let canvasSize: CGSize
    @GestureState private var dragAmount: CGSize = .zero
    var screenPattern: ScreenPattern {
        .init(pattern: spell.pattern.pattern, canvasSize: canvasSize)
    }
    
    var body: some View {
        ZStack {
            AnyShape(spell.pattern.shape)
                .stroke(style: StrokeStyle(lineWidth: 4))
                .foregroundColor(.blue)
            handle
        }
        .contentShape(Rectangle())
        .gesture(dragGesture)
    }
    
    private var handle: some View {
        GemView()
            .offset(gemPosition(index: 0, drag: dragAmount).viewOffset(canvasSize))
    }
    
    private func gemPosition(index: Int, drag: CGSize) -> Vector2 {
        var orig = gemPosition(index: index)
        orig.x += Float(drag.width)
        orig.y += Float(drag.height)
        return screenPattern.closestPoint(to: orig)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($dragAmount) { value, state, transaction in
                state = value.translation
            }
            .onEnded { drag in
                let endPosition = gemPosition(index: 0, drag: drag.translation)
                let time = screenPattern.time(position: endPosition)
                spell.gems[0].time = time
            }
    }
    
    private func gemPosition(index: Int) -> Vector2 {
        let gem = spell.gems[index]
        return screenPattern.position(time: gem.time)
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
