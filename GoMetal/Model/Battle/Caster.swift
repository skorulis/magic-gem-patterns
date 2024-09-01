//Created by Alexander Skorulis on 25/8/2024.

import Foundation
import VectorMath

struct Caster: Identifiable {
    
    let id = UUID()
    var health: Float = 10
    var activeSpell: Spell
    var position: Vector2
    var heading: Float
}
