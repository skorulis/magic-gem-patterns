//  Created by Alexander Skorulis on 19/7/2024.

import ASKCore
import Swinject

final class IOC: IOCService {
    override init(purpose: IOCPurpose = .testing) {
        super.init(purpose: purpose)
        MainActor.assumeIsolated {
            GoMetalAssembly().assemble(container: self.container)
        }
    }
}
