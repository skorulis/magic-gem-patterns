//Created by Alexander Skorulis on 25/8/2024.

import ASKCore
import Foundation

@Observable final class BattleTestViewModel: ResolverCoordinatorViewModel {
    
    let battleFactory: BattleSimulationFactory
    var simulation: BattleSimulation
    
    init(battleFactory: BattleSimulationFactory) {
        self.battleFactory = battleFactory
        self.simulation = battleFactory.make()
    }
}
