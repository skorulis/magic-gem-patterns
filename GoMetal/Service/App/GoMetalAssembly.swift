//Created by Alexander Skorulis on 24/8/2024.

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
        
        container.register(SpellStore.self) { _ in
            SpellStore()
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
                    service: r.resolve(SpellCastService.self)!,
                    mainStore: r.resolve(MainStore.self)!,
                    simulationFactory: r.resolve(SimulationServiceFactory.self)!
                )
            }
        )
        
        container.register(SelectGemViewModel.self) { r in
            SelectGemViewModel(mainView: r.mainStore())
        }
        
        container.register(MainMenuViewModel.self) { @MainActor r in
            MainMenuViewModel()
        }
    }
}