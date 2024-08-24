//  Created by Alexander Skorulis on 9/7/2024.

import ASKCore
import ASKDesignSystem
import SwiftUI

struct ContentView: View {
    
    let startDate = Date()
    @Environment(\.resolver) private var resolver
    
    var body: some View {
        CoordinatorView(
            coordinator: ResolverCoordinator(
                root: RootPath.main,
                resolver: resolver
            )
        )
    }
}

#Preview {
    ContentView()
}
