//Created by Alexander Skorulis on 25/8/2024.

import ASKDesignSystem
import SwiftUI

// MARK: - Memory footprint

@MainActor
struct BattleTestView {
    @State var viewModel: BattleTestViewModel
}

// MARK: - Rendering

extension BattleTestView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            nav
            Spacer()
        }
        .navigationBarHidden(true)
    }
    
    private var nav: some View {
        NavBar(
            left: .back(viewModel.back),
            mid: .title("Battle")
        )
    }
}
