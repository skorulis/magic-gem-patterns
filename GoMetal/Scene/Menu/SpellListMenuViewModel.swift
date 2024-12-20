//Created by Alexander Skorulis on 24/8/2024.

import ASKCore
import Foundation

@Observable final class SpellListMenuViewModel: ResolverCoordinatorViewModel {
    
    let spellStore: SpellStore
    var spells: [Spell] = []
    
    init(spellStore: SpellStore) {
        self.spellStore = spellStore
        super.init()
        spellStore.spellsPublisher.sink { spells in
            self.spells = spells
        }
        .store(in: &subscribers)
    }
}

extension SpellListMenuViewModel {
    
    func show(spell: Spell) {
        coordinator.push(RootPath.spellEditor(spell))
    }
    
    func new() {
        let spell = Spell.blank()
        spellStore.update(spell: spell)
        self.show(spell: spell)
        
    }
}
