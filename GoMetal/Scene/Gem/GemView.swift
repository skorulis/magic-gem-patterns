//  Created by Alexander Skorulis on 14/7/2024.

import SwiftUI

struct GemView: View {
    
    let gem: Gem
    let canvasSize: CGSize
    
    var space: NormalizedSpace { NormalizedSpace(canvasSize: canvasSize) }
    
    var body: some View {
        gem.shape.displayShape
            .fill(gem.color)
            .frame(
                width: abs(CGFloat(space.toScreenSpace(size: gem.size).x)),
                height: abs(CGFloat(space.toScreenSpace(size: gem.size).y))
            )
    }
}

extension Gem {
    var color: Color {
        switch type {
        case .raw:
            return .gray
        case .fire:
            return .red
        case .water:
            return .blue
        }
    }
}
