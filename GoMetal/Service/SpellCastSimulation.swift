//  Created by Alexander Skorulis on 15/7/2024.

import Foundation
import QuartzCore

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
    private var displaylink: CADisplayLink!
    var active: Bool = false {
        didSet {
            displaylink.isPaused = !active
        }
    }
    private var lastTime: TimeInterval = 0
    
    init(spellProvider: @escaping () -> Spell, spellCastService: SpellCastService) {
        self.spellCastService = spellCastService
        self.spellProvider = spellProvider
        displaylink = .init(target: self, selector: #selector(step(displaylink:)))
        displaylink.add(to: .current, forMode: .default)
        displaylink.isPaused = true
        lastTime = displaylink.targetTimestamp
    }
    
    func start() {
        lastTime = displaylink.targetTimestamp
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
        active = true
    }
    
    func stop() {
        active = false
    }
    
    @objc func step(displaylink: CADisplayLink) {
        let t = displaylink.targetTimestamp
        let delta = Float(t - lastTime)
        lastTime = t
        guard delta < 0.5 else { return }
        step(delta: delta)
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
