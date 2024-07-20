//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI
import VectorMath

struct ActiveSpellView: View {
    
    let canvasSize: CGSize
    let context: SpellContext
    var pattern: PatternProtocol { context.spell.pattern.pattern }
    var screenPattern: ScreenPattern { .init(pattern: pattern, canvasSize: canvasSize) }
    
    var body: some View {
        ZStack {
            ForEach(context.energy) { energy in
                energyView(energy: energy)
            }
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
    }
    
    private func energyView(energy: SpellEnergy) -> some View {
        spellIcon(energy)
            .offset(screenPattern.space.toScreenSpace(point: energy.position).viewOffset(canvasSize))
    }
    
    func spellIcon(_ energy: SpellEnergy) -> some View {
        Image(systemName: "arrow.up.circle.fill")
            .resizable()
            .frame(width: CGFloat(energy.power), height: CGFloat(energy.power))
            .rotationEffect(rotation(energy))
    }
    
    private func rotation(_ energy: SpellEnergy) -> Angle {
        let force = screenPattern.force(at: energy.position)
        let radians = Math.cartesianToPolar(x: force.x, y: force.y).theta
        return .radians(CGFloat(radians + .halfPi))
    }
}
