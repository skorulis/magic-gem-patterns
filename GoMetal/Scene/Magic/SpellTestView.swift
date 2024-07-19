//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI

struct SpellTestView: View {
    
    @State var spell: Spell = .init(
        pattern: .line,
        gems: [.init(time: 0.5)]
    )
    let service = SpellCastService()
    
    @State private var sliderValue: CGFloat = 0
    @State private var canvasSize: CGSize = .zero
    
    @State private var simulation = SimulationService()
    
    var body: some View {
        VStack(spacing: 16) {
            Picker("Pattern", selection: $spell.pattern) {
                ForEach(SpellPattern.allCases) { pattern in
                    Text(pattern.rawValue)
                        .tag(pattern)
                }
            }
            animation
            Toggle(isOn: $simulation.active) {
                Text("Active")
            }
            Button(action: {simulation.start(spell: spell) }) {
                Text("Start")
            }
        }
        .padding(.horizontal, 16)
    }
    
    private var animation: some View {
        TimelineView(.animation) { timeline in
            canvas
        }
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
            .overlay(maybeActiveSpell)
            .readSize(size: $canvasSize)
    }
    
    @ViewBuilder
    private var maybeActiveSpell: some View {
        if let context = simulation.context {
            ActiveSpellView(
                canvasSize: canvasSize,
                context: context
            )
        }
    }
    
    private var energy: SpellEnergy {
        service.calculateEnergy(
            pattern: spell.pattern,
            time: Float(sliderValue),
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
