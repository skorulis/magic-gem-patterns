//  Created by Alexander Skorulis on 15/7/2024.

import Foundation
import QuartzCore

@Observable final class SimulationService {
    
    var context: SpellContext?
    var displaylink: CADisplayLink!
    var active: Bool = false {
        didSet {
            displaylink.isPaused = !active
        }
    }
    var lastTime: TimeInterval = 0
    
    init() {
        displaylink = .init(target: self, selector: #selector(step))
        displaylink.add(to: .current, forMode: .default)
        displaylink.isPaused = true
        lastTime = displaylink.targetTimestamp
    }
    
    func start(spell: Spell) {
        let pos = spell.pattern.pattern.position(time: 0)
        let initialEnergy = SpellEnergy(time: 0, position: pos, power: 20)
        self.context = .init(
            spell: spell,
            startTime: Date(),
            energy: initialEnergy
        )
        active = true
    }
    
    @objc func step(displaylink: CADisplayLink) {
        let t = displaylink.targetTimestamp
        let delta = t - lastTime
        print(delta)
        lastTime = t
    }
    
}
