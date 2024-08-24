//  Created by Alexander Skorulis on 24/8/2024.

import ASKDesignSystem
import SwiftUI

struct MainMenuView: View {
    
    @StateObject var viewModel: MainMenuViewModel
    
    var body: some View {
        PageTemplate(
            nav: nav,
            content: content
        )
    }
    
    private func content() -> some View {
        VStack {
            Button(action: viewModel.editSpell) {
                Text("Edit Spells")
            }
            .buttonStyle(ASKButtonStyle())
        }
    }
    
    private func nav() -> some View {
        NavBar(mid: NavBarItem.title("Go Metal"))
    }
}
