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
            ForEach(spell.gems) { gemPos in
                handle(gemPos: gemPos)
            }
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
        .contentShape(Rectangle())
        .gesture(dragGesture)
    }
    
    private func handle(gemPos: GemPosition) -> some View {
        GemView(gem: gemPos.gem, canvasSize: canvasSize)
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
