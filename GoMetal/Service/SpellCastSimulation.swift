//  Created by Alexander Skorulis on 15/7/2024.

import Foundation

struct SpellCastSimulationFactory {
    
    let spellCastService: SpellCastService
    
    func make(spellProvider: @escaping () -> Spell) -> SpellCastSimulation {
        return SpellCastSimulation(spellProvider: spellProvider, spellCastService: spellCastService)
    }
}

@Observable final class SpellCastSimulation {
    
    private let spellCastService: SpellCastService
    private let spellProvider: () -> Spell
    var didFinishCast: ((CastResult) -> Void)?
    
    private(set) var context: SpellContext?
    private let deltaProvider = DeltaProvider()
    var active: Bool {
        get {
            deltaProvider.active
        }
        set {
            deltaProvider.active = newValue
        }
    }
    private var lastTime: TimeInterval = 0
    
    init(spellProvider: @escaping () -> Spell, spellCastService: SpellCastService) {
        self.spellCastService = spellCastService
        self.spellProvider = spellProvider
        deltaProvider.onStep = { [weak self] in
            self?.step(delta: $0)
        }
    }
    
    func start() {
        let spell = spellProvider()
        let pos = spell.pattern.position(time: 0)
        let initialEnergy = SpellEnergy(
            time: 0,
            position: pos,
            velocity: .zero,
            power: 20,
            energyDistribution: [.raw: 1]
        )
        context = .init(
            spell: spell,
            startTime: Date(),
            energy: [initialEnergy]
        )
        deltaProvider.start()
    }
    
    func stop() {
        active = false
    }
    
    func step(delta: Float) {
        guard var context else { return }
        spellCastService.update(context: &context, delta: delta)
        
        if context.completeness >= 1 {
            let result = spellCastService.result(context: context)
            
            print("FINISHED SPELL \(result.shape)")
            print("RESULT = \(result)")
            didFinishCast?(result)
            start()
        } else {
            self.context = context
        }
    }
    
}
