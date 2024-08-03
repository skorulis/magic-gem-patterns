//  Created by Alexander Skorulis on 19/7/2024.

import ASKCore
import Swinject

final class IOC: IOCService {
    override init(purpose: IOCPurpose = .testing) {
        super.init(purpose: purpose)
        registerStores()
        registerServices()
        registerViewModels()
    }
    
    private func registerStores() {
        container.register(MainStore.self) { _ in
            MainStore()
        }
        .inObjectScope(.container)
    }
    
    private func registerServices() {
        container.register(SpellCastService.self) { _ in SpellCastService() }
        
        container.register(SimulationService.self) { r in
            SimulationService(
                mainStore: r.resolve(MainStore.self)!,
                spellCastService: r.resolve(SpellCastService.self)!
            )
        }
    }
    
    private func registerViewModels() {
        container.register(SpellTestViewModel.self) { r in
            SpellTestViewModel(
                service: r.resolve(SpellCastService.self)!,
                mainStore: r.resolve(MainStore.self)!,
                simulation: r.resolve(SimulationService.self)!
            )
        }
        
        container.register(SelectGemViewModel.self) { r in
            SelectGemViewModel(mainView: r.resolve(MainStore.self)!)
        }
    }
}
