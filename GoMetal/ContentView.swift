//  Created by Alexander Skorulis on 9/7/2024.

import SwiftUI

struct ContentView: View {
    
    let startDate = Date()
    
    var body: some View {
        VStack {
            SpellTestView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
