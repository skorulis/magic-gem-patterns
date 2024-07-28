//  Created by Alexander Skorulis on 28/7/2024.

import Foundation

@Observable final class SpellTestViewModel {
    let service: SpellCastService
    let mainStore: MainStore
    let simulation: SimulationService
    
    var showingGems: Bool = false
    
    init(service: SpellCastService, mainStore: MainStore, simulation: SimulationService) {
        self.service = service
        self.mainStore = mainStore
        self.simulation = simulation
    }
}

extension SpellTestViewModel {
    func addPressed() {
        showingGems = true
    }
}
