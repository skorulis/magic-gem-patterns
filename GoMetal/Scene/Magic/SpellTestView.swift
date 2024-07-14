//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI

struct SpellTestView: View {
    
    @State var spell: Spell = .init(
        pattern: .line,
        gems: [.init(time: 0)]
    )
    let service = SpellCastService()
    
    @State private var sliderValue: CGFloat = 0
    @State private var canvasSize: CGSize = .zero
    
    var body: some View {
        VStack(spacing: 16) {
            Picker("Pattern", selection: $spell.pattern) {
                ForEach(SpellPattern.allCases) { pattern in
                    Text(pattern.rawValue)
                        .tag(pattern)
                }
            }
            canvas
            slider
        }
        .padding(.horizontal, 16)
        
    }
    
    private var canvas: some View {
        Circle()
            .fill(Color.clear)
            .overlay(
                DirectionalFieldView(pattern: spell.pattern, canvasSize: canvasSize)
            )
            .overlay(
                GemPositionEditView(spell: $spell, canvasSize: canvasSize)
            )
            .overlay(
                ActiveSpellView(
                    canvasSize: canvasSize,
                    pattern: spell.pattern,
                    energy: energy
                )
            )
            .readSize(size: $canvasSize)
    }
    
    private var energy: SpellEnergy {
        service.calculateEnergy(
            pattern: spell.pattern,
            time: sliderValue,
            canvasSize: canvasSize
        )
    }
    
    private var slider: some View {
        Slider(value: $sliderValue)
    }
    
}

#Preview {
    SpellTestView()
}
