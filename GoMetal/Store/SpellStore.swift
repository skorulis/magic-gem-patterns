//Created by Alexander Skorulis on 24/8/2024.

import ASKCore
import Foundation

final class SpellStore: ObservableObject {
    
    private let store: PKeyValueStore
    @Published private(set) var spells: [Spell] = []
    private static let storageKey = "SpellStore.storageKey"
    
    init(store: PKeyValueStore) {
        self.store = store
        self.spells = Self.readFromDisk(store: store).spells
    }
    
    func update(spell: Spell) {
        guard let index = spells.firstIndex(where: {$0.id == spell.id}) else {
            spells.append(spell)
            writeToDisk()
            return
        }
        spells[index] = spell
        writeToDisk()
    }
}

private extension SpellStore {
    struct DiskStorage: Codable {
        let spells: [Spell]
    }
}

extension SpellStore {
    func writeToDisk() {
        let storage = DiskStorage(spells: spells)
        try! store.set(codable: storage, forKey: Self.storageKey)
    }
    
    fileprivate static func readFromDisk(store: PKeyValueStore) -> DiskStorage {
        if let item: DiskStorage = try? store.codable(forKey: Self.storageKey) {
            return item
        }
        return DiskStorage(spells: [])
    }
}
