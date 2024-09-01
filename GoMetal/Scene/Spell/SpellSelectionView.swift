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
        NavBar(
            mid: .title("Select Spell"),
            right: .close(viewModel.dismiss)
        )
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
        Button(action: { didSelect(spell) }) {
            HStack {
                SpellIcon(spell: spell, size: 60)
                Text(spell.name)
                Spacer()
            }
        }
    }
    
    private func didSelect(_ spell: Spell) {
        onSelect(spell)
        viewModel.dismiss()
    }
}

// MARK: - Previews

#Preview {
    let ioc = IOC()
    let spellStore = ioc.container.spellStore()
    spellStore.update(spell: .blank())
    spellStore.update(spell: .singleGem())
    
    return SpellSelectionView(
        viewModel: ioc.resolve(),
        onSelect: { _ in }
    )
}

