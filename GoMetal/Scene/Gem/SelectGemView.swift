//  Created by Alexander Skorulis on 28/7/2024.

import SwiftUI

struct SelectGemView: View {
    
    @State var viewModel: SelectGemViewModel
    
    var body: some View {
        GemInventoryView(inventory: <#T##Inventory#>, canvasSize: <#T##CGSize#>, didSelect: <#T##(Gem) -> Void#>)
        VStack {
            Text("Gems")
        }
    }
}
