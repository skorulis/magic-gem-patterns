//  Created by Alexander Skorulis on 10/7/2024.

import Foundation

final class SpellCastService {
    
    private let stepSize: Float = 0.1
    
    func calculateEnergy(
        pattern: SpellPattern,
        time: Float,
        canvasSize: CGSize
    ) -> SpellEnergy {
        let screenPattern = ScreenPattern(pattern: pattern.pattern, canvasSize: canvasSize)
        var energy = SpellEnergy(
            time: 0,
            position: screenPattern.position(time: 0),
            velocity: .zero,
            power: pattern.basePower
        )
        
        while energy.time < time {
            let nextTime = min(energy.time + stepSize, time)
            energy = .init(
                time: nextTime,
                position: screenPattern.position(time: nextTime),
                velocity: .zero,
                power: pattern.basePower + nextTime * 20
            )
        }
        
        return energy
    }
}
