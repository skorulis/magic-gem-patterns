//Created by Alexander Skorulis on 25/8/2024.

import Foundation

struct Battle {
    
    var caster: Caster
    var particles: [BattleParticle] = []
}

extension Battle {
    enum Constants {
        static let casterSize: Float = 0.1
    }
}
