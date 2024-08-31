//Created by Alexander Skorulis on 31/8/2024.

import SwiftUI

struct BattleParticlesView: View {
    
    private let canvasSize: CGSize
    private let battle: Battle
    private let normalSpace: NormalizedSpace
    
    init(canvasSize: CGSize, battle: Battle) {
        self.canvasSize = canvasSize
        self.battle = battle
        self.normalSpace = .init(canvasSize: canvasSize)
    }
    
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
            .offset(normalSpace.toScreenSpace(point: particle.position).viewOffset(canvasSize))
    }
}
