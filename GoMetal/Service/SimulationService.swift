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
        let pos = spell.pattern.pattern.position(time: 0)
        let initialEnergy = SpellEnergy(time: 0, position: pos, velocity: .zero, power: 20)
        self.mainStore.spellContext = .init(
            spell: spell,
            startTime: Date(),
            energy: initialEnergy
        )
        active = true
    }
    
    @objc func step(displaylink: CADisplayLink) {
        guard var context else { return }
        let t = displaylink.targetTimestamp
        let delta = Float(t - lastTime)
        lastTime = t
        guard delta < 0.5 else { return }
        print(delta)
        spellCastService.update(context: &context, delta: delta)
        mainStore.spellContext = context
    }
    
}
