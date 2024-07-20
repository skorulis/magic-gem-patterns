//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI

struct SpellTestView: View {
    
    let service = SpellCastService()
    
    @State private var canvasSize: CGSize = .zero
    
    @State var mainStore: MainStore
    @State var simulation: SimulationService
    
    var pattern: PatternProtocol {
        return mainStore.spell.pattern.pattern
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Picker("Pattern", selection: $mainStore.spell.pattern) {
                ForEach(SpellPattern.allCases) { pattern in
                    Text(pattern.rawValue)
                        .tag(pattern)
                }
            }
            canvas
            Toggle(isOn: $simulation.active) {
                Text("Active")
            }
            Button(action: {simulation.start() }) {
                Text("Start")
            }
        }
        .padding(.horizontal, 16)
    }
    
    private var canvas: some View {
        Circle()
            .fill(Color.clear)
            .overlay(
                PatternView(
                    pattern: pattern,
                    canvasSize: canvasSize,
                    fillPct: simulation.context?.completeness ?? 0
                )
            )
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
    
}

#Preview {
    let ioc = IOC()
    return SpellTestView(
        mainStore: ioc.resolve(),
        simulation: ioc.resolve()
    )
}
