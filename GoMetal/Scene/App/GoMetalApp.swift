//  Created by Alexander Skorulis on 9/7/2024.

import ASKCore
import SwiftUI

@main
struct GoMetalApp: App {
    
    private let ioc = IOC(purpose: .normal)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.resolver, ioc.container)
        }
    }
}
