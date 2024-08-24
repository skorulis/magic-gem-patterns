//  Created by Alexander Skorulis on 28/7/2024.

import ASKCore
import Foundation

@Observable final class SpellTestViewModel: CoordinatedViewModel {
    let service: SpellCastService
    let mainStore: MainStore
    var simulation: SimulationService!
    
    var showingGems: Bool = false
    
    var spell: Spell
    
    init(
        spell: Spell,
        service: SpellCastService,
        mainStore: MainStore,
        simulationFactory: SimulationServiceFactory
    ) {
        self.service = service
        self.spell = spell
        self.mainStore = mainStore
        super.init()
        self.simulation = simulationFactory.make(spellProvider: { self.spell })
    }
}

extension SpellTestViewModel {
    func addPressed() {
        showingGems = true
    }
    
    func selectedGem(_ gem: Gem) {
        self.showingGems = false
        mainStore.inventory.remove(gem: gem)
        spell.gems.append(.init(gem: gem, time: 0))
    }
    
    func removedGem(_ gem: Gem) {
        mainStore.inventory.add(gem: gem)
    }
}
