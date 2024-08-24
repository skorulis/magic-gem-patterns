//  Created by Alexander Skorulis on 24/8/2024.

import ASKCore
import SwiftUI

enum RootPath: BoundCoordinatorPath, Hashable {
    case main
    case spellEditor
    
    @MainActor @ViewBuilder
    func render(coordinator: StandardCoordinator) -> some View {
        switch self {
        case .main:
            MainMenuView(viewModel: coordinator.resolve(MainMenuViewModel.self))
        case .spellEditor:
            SpellTestView(viewModel: coordinator.resolve())
        }
    }
    
    var id: String {
        String(describing: self)
    }
}
