//Created by Alexander Skorulis on 25/8/2024.

import Foundation

struct Battle {
    
    var casters: [Caster]
    var particles: [BattleParticle] = []
}

extension Battle {
    enum Constants {
        static let casterSize: Float = 0.1
        static let spellToBattleSpeed: Float = 0.3
        static let attractionMultiplier: Float = 0.1
    }
}
