//Created by Alexander Skorulis on 24/8/2024.

import Foundation

final class SpellStore: ObservableObject {
    
    @Published private(set) var spells: [Spell] = []
    
    func update(spell: Spell) {
        guard let index = spells.firstIndex(where: {$0.id == spell.id}) else {
            spells.append(spell)
            return
        }
        spells[index] = spell
    }
}
