//  Created by Alexander Skorulis on 28/7/2024.

import Foundation

@Observable final class SelectGemViewModel {
    
    var mainView: MainStore
    
    init(mainView: MainStore) {
        self.mainView = mainView
    }
    
}
