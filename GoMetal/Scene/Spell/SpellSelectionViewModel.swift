//Created by Alexander Skorulis on 1/9/2024.

import ASKCore
import Foundation

@Observable final class SpellSelectionViewModel: ResolverCoordinatorViewModel {
 
    private let spellStore: SpellStore
    
    var spells: [Spell] { spellStore.spells }
    
    init(spellStore: SpellStore) {
        self.spellStore = spellStore
    }
}
