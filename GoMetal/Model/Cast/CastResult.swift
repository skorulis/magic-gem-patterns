//  Created by Alexander Skorulis on 27/7/2024.

import Foundation
import VectorMath

enum SpellTarget {
    case enemy
    case caster
}

// What a spell pattern spits out when finished
struct CastResult {
    
    let energy: [SpellEnergy]
    
    let shape: SpellShape
    
    let target: SpellTarget
    
    // Total power in the spell
    let power: Float
    
    // How much the energy has moved
    let deviance: Float
    
    let velocitySum: Vector2
}
