//  Created by Alexander Skorulis on 27/7/2024.

import Foundation

// What a spell pattern spits out when finished
struct CastResult {
    
    let shape: SpellShape
    
    // Total power in the spell
    let power: Float
    
    // How much the energy has moved
    let deviance: Float
}
