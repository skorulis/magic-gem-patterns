//  Created by Alexander Skorulis on 15/7/2024.

import Foundation
import QuartzCore

@Observable final class SimulationService {
    
    private let mainStore: MainStore
    private let spellCastService: SpellCastService
    
    var context: SpellContext? { mainStore.spellContext }
    var displaylink: CADisplayLink!
    var active: Bool = false {
        didSet {
            displaylink.isPaused = !active
        }
    }
    var lastTime: TimeInterval = 0
    var spell: Spell { mainStore.spell }
    
    init(mainStore: MainStore, spellCastService: SpellCastService) {
        self.mainStore = mainStore
        self.spellCastService = spellCastService
        displaylink = .init(target: self, selector: #selector(step))
        displaylink.add(to: .current, forMode: .default)
        displaylink.isPaused = true
        lastTime = displaylink.targetTimestamp
    }
    
    func start() {
        lastTime = displaylink.targetTimestamp
        let spell = mainStore.spell
        let pos = spell.pattern.position(time: 0)
        let initialEnergy = SpellEnergy(
            time: 0,
            position: pos,
            velocity: .zero,
            power: 20,
            energyDistribution: [.raw: 1]
        )
        self.mainStore.spellContext = .init(
            spell: spell,
            startTime: Date(),
            energy: [initialEnergy]
        )
        active = true
    }
    
    func stop() {
        active = false
    }
    
    @objc func step(displaylink: CADisplayLink) {
        guard var context else { return }
        let t = displaylink.targetTimestamp
        let delta = Float(t - lastTime)
        lastTime = t
        guard delta < 0.5 else { return }
        spellCastService.update(context: &context, delta: delta)
        
        if context.completeness >= 1 {
            let result = spellCastService.result(context: context)
            
            print("FINISHED SPELL \(result.shape)")
            print("RESULT = \(result)")
            
            start()
        } else {
            mainStore.spellContext = context
        }
    }
    
}
