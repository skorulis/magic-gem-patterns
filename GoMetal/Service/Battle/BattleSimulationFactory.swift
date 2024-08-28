//Created by Alexander Skorulis on 25/8/2024.

import Foundation
import Swinject

struct BattleSimulationFactory {
    
    let resolver: Resolver
    
    func make() -> BattleSimulation {
        let spellStore = resolver.spellStore()
        let spell = spellStore.spells.first ?? .blank()
        return BattleSimulation(
            castFactory: resolver.spellCastSimulationFactory(),
            caster: Caster(activeSpell: spell)
        )
    }
}
