//Created by Alexander Skorulis on 25/8/2024.

import Foundation

final class BattleSimulation {
    
    let castFactory: SpellCastSimulationFactory
    
    var caster: Caster
    
    var spellSimulation: SpellCastSimulation
    
    init(castFactory: SpellCastSimulationFactory, caster: Caster) {
        self.castFactory = castFactory
        self.caster = caster
        spellSimulation = castFactory.make(spellProvider: { caster.activeSpell})
        
    }
}
