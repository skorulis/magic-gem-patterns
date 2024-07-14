//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI

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
        let p = screenPattern.closestPoint(to: .init(x: translation.width, y: translation.height))
        return .init(width: p.x - canvasSize.width / 2, height: p.y - canvasSize.height / 2)
    }
    
    private var originalHandleOffset: CGSize {
        gemOffset
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($dragAmount) { value, state, transaction in
                state = value.translation
            }
            .onEnded { drag in
                //self.rotation = handleAngle(translation: drag.translation)
            }
    }
    
    private var gemOffset: CGSize {
        let gem = spell.gems[0]
        let position = screenPattern.position(time: gem.time)
        return .init(width: position.x - canvasSize.width/2, height: position.y - canvasSize.height/2)
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
