//  Created by Alexander Skorulis on 24/8/2024.

import ASKCore
import SwiftUI

enum RootPath: BoundCoordinatorPath, Hashable {
    case main
    case spellEditor
    
    @MainActor @ViewBuilder
    func render(coordinator: ResolverCoordinator) -> some View {
        switch self {
        case .main:
            MainMenuView(viewModel: coordinator.make { $0.mainMenuViewModel() })
        case .spellEditor:
            SpellTestView(viewModel: coordinator.make { $0.spellTestViewModel(spell: .blank())}  )
        }
    }
    
    var id: String {
        String(describing: self)
    }
}
