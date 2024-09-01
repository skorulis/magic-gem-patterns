//Created by Alexander Skorulis on 1/9/2024.

import ASKDesignSystem
import Foundation
import SwiftUI

// MARK: - Memory footprint

@MainActor
struct SpellSelectionView {
    @State var viewModel: SpellSelectionViewModel
    let onSelect: (Spell) -> Void
}

// MARK: - Rendering

extension SpellSelectionView: View {
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageTemplate(nav: nav, content: content)
        }
    }
    
    private func nav() -> some View {
        NavBar(left: .back(viewModel.back), mid: .title("Spells"))
    }
    
    private func content() -> some View {
        VStack {
            ForEach(viewModel.spells) { spell in
                spellButton(spell: spell)
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func spellButton(spell: Spell) -> some View {
        Button(action: { onSelect(spell) }) {
            HStack {
                SpellIcon(spell: spell, size: 60)
                Text(spell.name)
                Spacer()
            }
        }
    }
}

// MARK: - Previews

#Preview {
    let ioc = IOC()
    return SpellSelectionView(
        viewModel: ioc.resolve(),
        onSelect: { _ in }
    )
}

