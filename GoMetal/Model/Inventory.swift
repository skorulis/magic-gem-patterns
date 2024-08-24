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
                .baseSquare,
            ]
        )
    }
    
    mutating func remove(gem: Gem) {
        self.gems = self.gems.filter { $0.id != gem.id }
    }
    
    mutating func add(gem: Gem) {
        self.gems.append(gem)
    }
}
