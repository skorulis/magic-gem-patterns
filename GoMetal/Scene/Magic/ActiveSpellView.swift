//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import SwiftUI

struct ActiveSpellView: View {
    
    let canvasSize: CGSize
    let pattern: SpellPattern
    let time: CGFloat
    
    var body: some View {
        ZStack {
            spellIcon
                .offset(pattern.position(time: time, size: canvasSize))
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
    }
    
    var spellIcon: some View {
        Circle()
            .frame(width: 40, height: 40)
    }
}
