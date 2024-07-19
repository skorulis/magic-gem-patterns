//  Created by Alexander Skorulis on 19/7/2024.

import ASKCore
import Swinject

final class IOC: IOCService {
    override init(purpose: IOCPurpose = .testing) {
        super.init(purpose: purpose)
        registerStores()
        registerServices()
    }
    
    func registerStores() {
        container.register(MainStore.self) { _ in
            MainStore()
        }
        .inObjectScope(.container)
    }
    
    func registerServices() {
        container.register(SpellCastService.self) { _ in SpellCastService() }
        
        container.register(SimulationService.self) { r in
            SimulationService(
                mainStore: r.resolve(MainStore.self)!,
                spellCastService: r.resolve(SpellCastService.self)!
            )
        }
    }
}
