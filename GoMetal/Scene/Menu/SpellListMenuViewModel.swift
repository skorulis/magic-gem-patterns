//Created by Alexander Skorulis on 24/8/2024.

import ASKCore
import Foundation

@Observable final class SpellListMenuViewModel: ResolverCoordinatorViewModel {
    
    let spellStore: SpellStore
    var spells: [Spell] = []
    
    init(spellStore: SpellStore) {
        self.spellStore = spellStore
        super.init()
        spellStore.$spells.sink { spells in
            self.spells = spells
        }
        .store(in: &subscribers)
    }
}

extension SpellListMenuViewModel {
    
    func show(spell: Spell) {
        coordinator.push(RootPath.spellEditor(spell))
    }
}
