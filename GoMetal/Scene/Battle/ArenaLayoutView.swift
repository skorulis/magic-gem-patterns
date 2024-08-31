//Created by Alexander Skorulis on 29/8/2024.

import SwiftUI
import VectorMath

// MARK: - Memory footprint

struct ArenaLayoutView {
    private let battle: Battle
    private let canvasSize: CGSize
    private let normalSpace: NormalizedSpace
    
    init(battle: Battle, canvasSize: CGSize) {
        self.battle = battle
        self.canvasSize = canvasSize
        self.normalSpace = .init(canvasSize: canvasSize)
    }
}

// MARK: - Rendering

extension ArenaLayoutView: View {
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.black)
            casters
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
    }
    
    private var casters: some View {
        return casterView(caster: battle.caster)
    }
    
    private func casterView(caster: Caster) -> some View {
        let size = normalSpace.toScreenSpace(
            size: .init(Battle.Constants.casterSize, Battle.Constants.casterSize)
        )
        let offset = normalSpace.toScreenSpace(size: caster.position)
        
        return Image(systemName: "person.circle")
            .resizable()
            .frame(
                width: CGFloat(size.x),
                height: CGFloat(abs(size.y))
            )
            .offset(x: CGFloat(offset.x), y: CGFloat(offset.y))
    }
}

// MARK: - Previews

#Preview {
    let caster1 = Caster(
        health: 1,
        activeSpell: .blank(),
        position: .init(0, -0.5)
    )
    let battle = Battle(caster: caster1)
    return ArenaLayoutView(
        battle: battle,
        canvasSize: .init(width: 300, height: 300)
    )
}

