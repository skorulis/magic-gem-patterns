//Created by Alexander Skorulis on 24/8/2024.

import ASKDesignSystem
import SwiftUI

// MARK: - Memory footprint

@MainActor
struct SpellListMenu {
    
    @State var viewModel: SpellListMenuViewModel
}

// MARK: - Rendering

extension SpellListMenu: View {
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageTemplate(nav: nav, content: content)
            addButton()
        }
    }
    
    private func nav() -> some View {
        NavBar(left: .back(viewModel.back), mid: .title("Spells"))
    }
    
    private func content() -> some View {
        VStack {
            
        }
    }
    
    private func addButton() -> some View {
        Button(action: { viewModel.show(spell: .blank()) }) {
            Image(systemName: "plus")
                .resizable()
                .fontWeight(.bold)
                .padding(16)
        }
        .buttonStyle(CircularButtonStyle())
        .padding(.trailing, 16)
    }
}
