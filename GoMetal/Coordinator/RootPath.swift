//  Created by Alexander Skorulis on 24/8/2024.

import ASKCore
import SwiftUI

enum RootPath: BoundCoordinatorPath, Hashable {
    case main
    case spellList
    case spellEditor(Spell)
    
    @MainActor @ViewBuilder
    func render(coordinator: ResolverCoordinator) -> some View {
        switch self {
        case .main:
            MainMenuView(viewModel: coordinator.make { $0.mainMenuViewModel() })
        case .spellList:
            SpellListMenu(viewModel: coordinator.make { $0.spellListMenuViewModel() })
        case let .spellEditor(spell):
            SpellTestView(viewModel: coordinator.make { $0.spellTestViewModel(spell: spell)} )
        }
    }
    
    var id: String {
        String(describing: self)
    }
}
