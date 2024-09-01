//Created by Alexander Skorulis on 25/8/2024.

import ASKCore
import Foundation

final class BattleTestViewModel: ResolverCoordinatorViewModel, ObservableObject {
    
    let battleFactory: BattleSimulationFactory
    var simulation: BattleSimulation
    var battle: Battle { simulation.battle }
    
    init(battleFactory: BattleSimulationFactory) {
        self.battleFactory = battleFactory
        self.simulation = battleFactory.make()
        super.init()
        simulation.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        .store(in: &subscribers)
    }
}

// MARK: - Computed values

extension BattleTestViewModel {
    
    var casterSpell: Spell {
        battle.casters[0].activeSpell
    }
}

// MARK: - Logic

extension BattleTestViewModel {
    
    func selectSpell() {
        coordinator.present(RootPath.selectSpell(setSpell), style: .sheet)
    }
        
    func setSpell(spell: Spell) {
        simulation.change(spell: spell)
    }
}
