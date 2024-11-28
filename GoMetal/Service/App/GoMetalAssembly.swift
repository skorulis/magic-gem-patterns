//Created by Alexander Skorulis on 24/8/2024.

import ASKCore
import Knit

final class GoMetalAssembly: AutoInitModuleAssembly {
    typealias TargetResolver = Resolver
    static var dependencies: [any Knit.ModuleAssembly.Type] = []
    
    func assemble(container: Container) {
        registerFactories(container: container)
        registerStores(container: container)
        registerServices(container: container)
        registerViewModels(container: container)
    }
    
    private func registerFactories(container: Container) {
        container.register(BattleSimulationFactory.self) { r in
            BattleSimulationFactory(resolver: r)
        }
        
        container.register(SpellCastSimulationFactory.self) { r in
            SpellCastSimulationFactory(spellCastService: r.spellCastService())
        }
    }
    
    private func registerStores(container: Container) {
        container.register(MainStore.self) { _ in
            MainStore()
        }
        .inObjectScope(.container)
        
        container.register(SpellStore.self, factory: RealSpellStore.make)
            .inObjectScope(.container)
    }
    
    private func registerServices(container: Container) {
        container.register(SpellCastService.self, factory: SpellCastService.make)
        
        container.register(SpellShapeMatcher.self) { _ in
            SpellShapeMatcher()
        }
    }
    
    private func registerViewModels(container: Container) {
        container.register(
            SpellTestViewModel.self,
            mainActorFactory: { (r: Resolver, spell: Spell) in
                SpellTestViewModel.make(resolver: r, spell: spell)
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
        
        container.register(BattleTestViewModel.self) { @MainActor r in
            BattleTestViewModel(battleFactory: r.battleSimulationFactory())
        }
        
        container.register(SpellSelectionViewModel.self) { @MainActor r in
            SpellSelectionViewModel(spellStore: r.spellStore())
        }
    }
}

extension Resolver {
    func pKeyValueStore() -> PKeyValueStore {
        self.resolve(PKeyValueStore.self)!
    }
}
