//  Created by Alexander Skorulis on 14/7/2024.

import SwiftUI

struct GemView: View {
    
    let gem: Gem
    let canvasSize: CGSize
    
    var space: PatternSpace { PatternSpace(canvasSize: canvasSize) }
    
    var body: some View {
        Rectangle()
            .fill(Color.red)
            .frame(
                width: abs(CGFloat(space.toScreenSpace(size: gem.size).x)),
                height: abs(CGFloat(space.toScreenSpace(size: gem.size).y))
            )
    }
}

