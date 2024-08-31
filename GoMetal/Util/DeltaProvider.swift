//Created by Alexander Skorulis on 28/8/2024.

import Foundation
import QuartzCore

final class DeltaProvider {
    var onStep: ((Float) -> Void)?
    private var displaylink: CADisplayLink!
    private var lastTime: TimeInterval = 0
    var active: Bool = false {
        didSet {
            displaylink.isPaused = !active
        }
    }
    
    init() {
        displaylink = .init(target: self, selector: #selector(step(displaylink:)))
        displaylink.add(to: .current, forMode: .default)
        displaylink.isPaused = true
        lastTime = displaylink.targetTimestamp
    }
    
    func start() {
        lastTime = displaylink.targetTimestamp
        active = true
    }
    
    @objc func step(displaylink: CADisplayLink) {
        let t = displaylink.targetTimestamp
        let delta = Float(t - lastTime)
        lastTime = t
        guard delta < 0.5 else { return }
        onStep?(delta)
    }
}
