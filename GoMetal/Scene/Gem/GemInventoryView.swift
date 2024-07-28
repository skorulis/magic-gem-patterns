//  Created by Alexander Skorulis on 28/7/2024.

import SwiftUI

struct GemInventoryView: View {
    let inventory: Inventory
    let canvasSize: CGSize
    let didSelect: (Gem) -> Void
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(inventory.gems) { gem in
                    Button(action: {didSelect(gem)}) {
                        GemView(gem: gem, canvasSize: canvasSize)
                    }
                }
            }
        }
    }
}
