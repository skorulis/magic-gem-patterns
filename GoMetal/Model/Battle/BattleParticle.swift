//Created by Alexander Skorulis on 31/8/2024.

import Foundation
import VectorMath

struct BattleParticle: Hashable, Identifiable {
    let id: UUID = .init()
    var position: Vector2
    var velocity: Vector2
    var power: Float
}
