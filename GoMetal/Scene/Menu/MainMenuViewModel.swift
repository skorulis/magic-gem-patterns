//  Created by Alexander Skorulis on 24/8/2024.

import ASKCore
import Foundation

final class MainMenuViewModel: CoordinatedViewModel, ObservableObject {

    override init() {
        
    }
}

// MARK: - Logic

extension MainMenuViewModel {
    
    func editSpell() {
        coordinator?.push(RootPath.spellEditor)
    }
}
