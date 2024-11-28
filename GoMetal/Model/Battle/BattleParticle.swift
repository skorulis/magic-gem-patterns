//Created by Alexander Skorulis on 31/8/2024.

import Foundation
import VectorMath

struct BattleParticle: Hashable, Identifiable {
    let casterID: UUID
    let id: UUID = .init()
    var position: Vector2
    var velocity: Vector2
    var power: Float
    var flags: Flags = []
}

extension BattleParticle {
    struct Flags: OptionSet, Hashable {
        let rawValue: Int
        
        static let isDead = Self(rawValue: 1 << 0)
    }
}
