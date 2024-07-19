//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import VectorMath

struct SpellEnergy: Identifiable {
    let id: UUID = .init()
    let time: Float
    var position: Vector2
    let power: Float
    
}
