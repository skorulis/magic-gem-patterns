//  Created by Alexander Skorulis on 15/7/2024.

import Foundation

struct SpellContext {
    let spell: Spell
    let startTime: Date
    var energy: [SpellEnergy]
    var completeness: Float = 0
}
