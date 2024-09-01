//Created by Alexander Skorulis on 1/9/2024.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct SpellIcon {
    let spell: Spell
    let size: CGFloat
}

// MARK: - Rendering

extension SpellIcon: View {
    
    var body: some View {
        ZStack {
            pattern
            gems
        }
        .frame(width: size, height: size)
        .padding(2)
        .border(Color.black)
    }
    
    private var pattern: some View {
        PatternView(
            pattern: spell.pattern,
            canvasSize: .init(width: size, height: size),
            fillPct: 0
        )
    }
    
    private var gems: some View {
        ZStack {
            ForEach(Array(spell.gems.enumerated()), id: \.offset) { index, gemPos in
                GemView(gem: gemPos.gem, canvasSize: .init(width: size, height: size))
            }
        }
    }
}

// MARK: - Previews

#Preview {
    VStack {
        SpellIcon(spell: .blank(), size: 60)
        
        SpellIcon(spell: .singleGem(), size: 60)
    }
    
}

