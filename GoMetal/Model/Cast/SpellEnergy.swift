//  Created by Alexander Skorulis on 10/7/2024.

import Foundation
import VectorMath
import SwiftUI

struct SpellEnergy: Identifiable {
    let id: UUID = .init()
    var gemIDs: Set<UUID> = []
    let time: Float
    var position: Vector2
    var velocity: Vector2
    var power: Float
    
    var color: Color {
        gemIDs.isEmpty ? .black : .orange
    }
    
}
