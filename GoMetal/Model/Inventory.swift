//  Created by Alexander Skorulis on 28/7/2024.

import Foundation

struct Inventory {
    var gems: [Gem]
    
    static var starting: Inventory {
        .init(
            gems: [
                .baseDiamond,
                .baseDiamond,
                .baseHexagon,
            ]
        )
    }
}
