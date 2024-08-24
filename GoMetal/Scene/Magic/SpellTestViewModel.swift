//  Created by Alexander Skorulis on 28/7/2024.

import ASKCore
import Foundation

@Observable final class SpellTestViewModel: ResolverCoordinatorViewModel {
    let service: SpellCastService
    let mainStore: MainStore
    let spellStore: SpellStore
    var simulation: SimulationService!
    
    var showingGems: Bool = false
    var showingNameEdit: Bool = false
    
    var spell: Spell {
        didSet {
            spellStore.update(spell: spell)
        }
    }
    
    init(
        spell: Spell,
        service: SpellCastService,
        mainStore: MainStore,
        spellStore: SpellStore,
        simulationFactory: SimulationServiceFactory
    ) {
        self.service = service
        self.spell = spell
        self.mainStore = mainStore
        self.spellStore = spellStore
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
    
    func deleteSpell() {
        
    }
    
    func renameSpell() {
        self.showingNameEdit = true
    }
}
