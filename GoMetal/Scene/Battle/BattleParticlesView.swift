//Created by Alexander Skorulis on 31/8/2024.

import SwiftUI

struct BattleParticlesView: View {
    
    let canvasSize: CGSize
    let battle: Battle
    
    var body: some View {
        ZStack {
            ForEach(battle.particles) { particle in
                particleView(particle: particle)
            }
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
    }
    
    private func particleView(particle: BattleParticle) -> some View {
        Image(systemName: "arrow.up.circle.fill")
            .resizable()
            .frame(width: CGFloat(particle.power), height: CGFloat(particle.power))
            //.offset(screenPattern.space.toScreenSpace(point: energy.position).viewOffset(canvasSize))
    }
}
