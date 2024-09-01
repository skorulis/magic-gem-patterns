//  Created by Alexander Skorulis on 24/8/2024.

import ASKCore
import SwiftUI

enum RootPath: BoundCoordinatorPath, Hashable {
    case main
    case spellList
    case spellEditor(Spell)
    case battleTest
    case selectSpell(_ onSelect: (Spell) -> Void)
    
    @MainActor @ViewBuilder
    func render(coordinator: ResolverCoordinator) -> some View {
        switch self {
        case .main:
            MainMenuView(viewModel: coordinator.make { $0.mainMenuViewModel() })
        case .spellList:
            SpellListMenu(viewModel: coordinator.make { $0.spellListMenuViewModel() })
        case let .spellEditor(spell):
            SpellTestView(viewModel: coordinator.make { $0.spellTestViewModel(spell: spell)} )
        case .battleTest:
            BattleTestView(viewModel: coordinator.make { $0.battleTestViewModel()} )
        case let .selectSpell(onSelect):
            SpellSelectionView(viewModel: coordinator.make { $0.spellSelectionViewModel() }, onSelect: onSelect)
        }
    }
    
    var id: String {
        String(describing: self)
    }
    
    static func == (lhs: RootPath, rhs: RootPath) -> Bool {
        switch (lhs, rhs) {
        case (.main, .main): return true
        case (.spellList, .spellList): return true
        case (.battleTest, .battleTest): return true
        case (.spellEditor(let s1), .spellEditor(let s2)):
            return s1 == s2
        case (.selectSpell, .selectSpell): return true
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        switch self {
        case let .spellEditor(spell):
            hasher.combine(spell)
        default:
            break
        }
    }
}
