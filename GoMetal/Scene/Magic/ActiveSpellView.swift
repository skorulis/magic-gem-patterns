//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI
import VectorMath

struct ActiveSpellView: View {
    
    let canvasSize: CGSize
    let pattern: SpellPattern
    let energy: SpellEnergy
    var screenPattern: ScreenPattern { .init(pattern: pattern.pattern, canvasSize: canvasSize) }
    
    var body: some View {
        ZStack {
            spellIcon
                .offset(energy.position.viewOffset(canvasSize))
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
    }
    
    var spellIcon: some View {
        Image(systemName: "arrow.up.circle.fill")
            .resizable()
            .frame(width: CGFloat(energy.power), height: CGFloat(energy.power))
            .rotationEffect(rotation)
    }
    
    var rotation: Angle {
        let force = screenPattern.force(at: energy.position)
        let radians = Math.cartesianToPolar(x: force.x, y: force.y).theta
        return .radians(CGFloat(radians + .halfPi))
    }
}
