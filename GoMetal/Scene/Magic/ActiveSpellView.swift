//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI

struct ActiveSpellView: View {
    
    let canvasSize: CGSize
    let pattern: SpellPattern
    let energy: SpellEnergy
    
    var body: some View {
        ZStack {
            spellIcon
                .offset(energy.position.viewOffset(canvasSize))
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
    }
    
    var spellIcon: some View {
        Circle()
            .frame(width: CGFloat(energy.power), height: CGFloat(energy.power))
    }
}
