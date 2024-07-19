//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI

struct SpellTestView: View {
    
    let service = SpellCastService()
    
    @State private var sliderValue: CGFloat = 0
    @State private var canvasSize: CGSize = .zero
    
    @State var mainStore: MainStore
    @State var simulation: SimulationService
    
    var body: some View {
        VStack(spacing: 16) {
            Picker("Pattern", selection: $mainStore.spell.pattern) {
                ForEach(SpellPattern.allCases) { pattern in
                    Text(pattern.rawValue)
                        .tag(pattern)
                }
            }
            animation
            Toggle(isOn: $simulation.active) {
                Text("Active")
            }
            Button(action: {simulation.start() }) {
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
                DirectionalFieldView(pattern: mainStore.spell.pattern, canvasSize: canvasSize)
            )
            .overlay(
                GemPositionEditView(spell: $mainStore.spell, canvasSize: canvasSize)
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
            pattern: mainStore.spell.pattern,
            time: Float(sliderValue),
            canvasSize: canvasSize
        )
    }
    
    private var slider: some View {
        Slider(value: $sliderValue)
    }
    
}

#Preview {
    let ioc = IOC()
    return SpellTestView(
        mainStore: ioc.resolve(),
        simulation: ioc.resolve()
    )
}
