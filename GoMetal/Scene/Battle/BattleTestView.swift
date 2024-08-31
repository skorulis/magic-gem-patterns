//Created by Alexander Skorulis on 25/8/2024.

import ASKDesignSystem
import SwiftUI

// MARK: - Memory footprint

@MainActor
struct BattleTestView {
    @State var viewModel: BattleTestViewModel
    @State private var canvasSize: CGSize = .zero
}

// MARK: - Rendering

extension BattleTestView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            nav
            
            Circle()
                .fill(Color.clear)
                .readSize(size: $canvasSize)
                .overlay(arena)
            
            
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
    
    private var arena: some View {
        ZStack {
            ArenaLayoutView(battle: viewModel.battle, canvasSize: canvasSize)
            BattleParticlesView(canvasSize: canvasSize, battle: viewModel.battle)
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
    }
    
    private var nav: some View {
        NavBar(
            left: .back(viewModel.back),
            mid: .title("Battle")
        )
    }
}
