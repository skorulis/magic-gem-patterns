//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI
import VectorMath

struct GemPositionEditView: View {
    
    @Binding var spell: Spell
    let canvasSize: CGSize
    @GestureState private var dragAmount: [Int: CGSize] = [:]
    var screenPattern: ScreenPattern {
        .init(pattern: spell.pattern, canvasSize: canvasSize)
    }
    
    var body: some View {
        canvas
    }
    
    private var canvas: some View {
        ZStack {
            ForEach(Array(spell.gems.enumerated()), id: \.offset) { index, gemPos in
                handle(index: index, gemPos: gemPos)
                    .gesture(dragGesture(index: index))
            }
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
        .contentShape(Rectangle())
        
    }
    
    private func handle(index: Int, gemPos: GemPosition) -> some View {
        GemView(gem: gemPos.gem, canvasSize: canvasSize)
            .offset(gemPosition(index: index, drag: dragAmount[index]).viewOffset(canvasSize))
    }
    
    private func gemPosition(index: Int, drag: CGSize?) -> Vector2 {
        var orig = gemPosition(index: index)
        orig.x += Float(drag?.width ?? 0)
        orig.y += Float(drag?.height ?? 0)
        
        if isNearPattern(position: orig) {
            return screenPattern.closestPoint(to: orig)
        } else {
            return orig
        }
    }
    
    private func dragGesture(index: Int) -> some Gesture {
        DragGesture()
            .updating($dragAmount) { value, state, transaction in
                state[index] = value.translation
            }
            .onEnded { drag in
                let endPosition = gemPosition(index: index, drag: drag.translation)
                if isNearPattern(position: endPosition) {
                    let time = screenPattern.time(position: endPosition)
                    spell.gems[index].time = time
                } else {
                    spell.gems.remove(at: index)
                }
            }
    }
    
    private func isNearPattern(position: Vector2) -> Bool {
        let patternPosition = screenPattern.closestPoint(to: position)
        let distance = (position - patternPosition).length
        return distance < Float(canvasSize.width / 8)
    }
    
    private func gemPosition(index: Int) -> Vector2 {
        let gem = spell.gems[index]
        return screenPattern.position(time: gem.time)
    }
    
    private var gemContainer: some View {
        HStack {
            Circle()
                .frame(width: 50, height: 50)
                .draggable("Test")
        }
    }
}
