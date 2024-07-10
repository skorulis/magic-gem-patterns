//  Created by Alexander Skorulis on 10/7/2024.

import Foundation

final class SpellCastService {
    
    private let stepSize = 0.1
    
    func calculateEnergy(
        pattern: SpellPattern,
        time: CGFloat,
        canvasSize: CGSize
    ) -> SpellEnergy {
        var energy = SpellEnergy(
            time: 0,
            position: pattern.position(time: 0, size: canvasSize),
            power: pattern.basePower
        )
        
        while energy.time < time {
            let nextTime = min(energy.time + stepSize, time)
            energy = .init(
                time: nextTime,
                position: pattern.position(time: nextTime, size: canvasSize),
                power: pattern.basePower + nextTime * 20
            )
        }
        
        return energy
    }
}
