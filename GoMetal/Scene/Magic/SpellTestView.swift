//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI

@MainActor
struct SpellTestView: View {
    
    @State var viewModel: SpellTestViewModel
    @State var mainStore: MainStore
    @State var simulation: SimulationService
    
    init(viewModel: SpellTestViewModel) {
        self.viewModel = viewModel
        self.mainStore = viewModel.mainStore
        self.simulation = viewModel.simulation
    }
    
    @State private var canvasSize: CGSize = .zero
    
    var pattern: PatternProtocol {
        return viewModel.spell.pattern
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Picker("Pattern", selection: $viewModel.spell.patternType) {
                ForEach(SpellPattern.allCases) { pattern in
                    Text(pattern.rawValue)
                        .tag(pattern)
                }
            }
            canvas
            buttonsView
            if viewModel.simulation.active {
                Button(action: { viewModel.simulation.stop() }) {
                    Text("Stop")
                }
            } else {
                Button(action: { viewModel.simulation.start() }) {
                    Text("Start")
                }
            }
            
        }
        .padding(.horizontal, 16)
        .sheet(isPresented: $viewModel.showingGems) {
            GemInventoryView(
                inventory: viewModel.mainStore.inventory,
                canvasSize: canvasSize,
                didSelect: viewModel.selectedGem
            )
            .presentationDetents([.medium])
        }
    }
    
    private var buttonsView: some View {
        HStack {
            Button(action: viewModel.addPressed) {
                Image(systemName: "plus")
                    .resizable()
                    .fontWeight(.bold)
                    .padding(16)
            }
            .buttonStyle(CircularButtonStyle())
        }
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
                DirectionalFieldView(
                    pattern: viewModel.spell.pattern,
                    canvasSize: canvasSize,
                    forceType: .all
                )
            )
            .overlay(
                GemPositionEditView(
                    spell: $viewModel.spell,
                    canvasSize: canvasSize,
                    didRemoveGem: viewModel.removedGem
                )
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
        viewModel: ioc.resolve()
    )
}
