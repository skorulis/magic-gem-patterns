//  Created by Alexander Skorulis on 12/8/2024.

import Foundation
import SwiftUI

enum EnergyType {
    case raw
    case fire
    case water
    
    var color: Color {
        switch self {
        case .raw:
            return .gray
        case .fire:
            return .red
        case .water:
            return .blue
        }
    }
}
