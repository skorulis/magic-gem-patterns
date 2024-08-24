//  Created by Alexander Skorulis on 10/7/2024.

import ASKCore
import ASKDesignSystem
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
        VStack(spacing: 0) {
            nav()
            content()
            Spacer()
        }
        .navigationBarHidden(true)
        .alert("Enter spell name", isPresented: $viewModel.showingNameEdit) {
            TextField("Enter spell name", text: $viewModel.spell.name)
            Button("OK", action: {})
        }
    }
    
    private func content() -> some View {
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
    
    private func nav() -> some View {
        NavBar(
            left: .back(viewModel.back),
            mid: .title(viewModel.spell.name),
            right: .customView(AnyView(rightMenu))
        )
    }
    
    private var rightMenu: some View {
        Menu {
            Button(action: viewModel.renameSpell) {
                Label("Rename Spell", systemImage: "pencil")
            }
            Button(role: .destructive, action: viewModel.deleteSpell) {
                Label("Delete Spell", systemImage: "trash")
            }
        } label: {
            Label(
                title: { EmptyView() },
                icon: { Image(systemName: "ellipsis") }
            )
        }
        .padding(.trailing, 16)

    }
}

#Preview {
    let ioc = IOC()
    return SpellTestView(
        viewModel: ioc.resolve()
    )
}
