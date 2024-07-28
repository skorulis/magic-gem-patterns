//  Created by Alexander Skorulis on 9/7/2024.

import SwiftUI

struct ContentView: View {
    
    let startDate = Date()
    @Environment(\.factory) private var factory
    
    var body: some View {
        VStack {
            SpellTestView(
                viewModel: factory.resolve()
            )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
