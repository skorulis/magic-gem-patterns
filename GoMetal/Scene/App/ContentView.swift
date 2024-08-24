//  Created by Alexander Skorulis on 9/7/2024.

import ASKCore
import ASKDesignSystem
import SwiftUI

struct ContentView: View {
    
    let startDate = Date()
    @Environment(\.factory) private var factory
    
    var body: some View {
        CoordinatorView(
            coordinator: StandardCoordinator(
                root: RootPath.main,
                factory: factory.main
            )
        )
    }
}

#Preview {
    ContentView()
}
