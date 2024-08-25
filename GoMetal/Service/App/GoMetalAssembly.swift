//Created by Alexander Skorulis on 24/8/2024.

import ASKCore
import Knit

final class GoMetalAssembly: AutoInitModuleAssembly {
    typealias TargetResolver = Resolver
    static var dependencies: [any Knit.ModuleAssembly.Type] = []
    
    func assemble(container: Container) {
        registerStores(container: container)
        registerServices(container: container)
        registerViewModels(container: container)
    }
    
    private func registerStores(container: Container) {
        container.register(MainStore.self) { _ in
            MainStore()
        }
        .inObjectScope(.container)
        
        container.register(SpellStore.self) { r in
            SpellStore(store: r.resolve(PKeyValueStore.self)!)
        }
        .inObjectScope(.container)
    }
    
    private func registerServices(container: Container) {
        container.register(SpellCastService.self) { r in
            SpellCastService(shapeMatcher: r.spellShapeMatcher())
        }
        
        container.register(SpellShapeMatcher.self) { _ in
            SpellShapeMatcher()
        }
        
        container.register(SimulationServiceFactory.self) { r in
            SimulationServiceFactory(spellCastService: r.spellCastService())
        }
    }
    
    private func registerViewModels(container: Container) {
        container.register(
            SpellTestViewModel.self,
            mainActorFactory: { (r: Resolver, spell: Spell) in
                SpellTestViewModel(
                    spell: spell,
                    service: r.spellCastService(),
                    mainStore: r.mainStore(),
                    spellStore: r.spellStore(),
                    simulationFactory: r.simulationServiceFactory()
                )
            }
        )
        
        container.register(SelectGemViewModel.self) { r in
            SelectGemViewModel(mainView: r.mainStore())
        }
        
        container.register(MainMenuViewModel.self) { @MainActor r in
            MainMenuViewModel()
        }
        
        container.register(SpellListMenuViewModel.self) { @MainActor r in
            SpellListMenuViewModel(spellStore: r.spellStore())
        }
        
        container.register(BattleTestViewModel.self) { @MainActor _ in
            BattleTestViewModel()
        }
    }
}
