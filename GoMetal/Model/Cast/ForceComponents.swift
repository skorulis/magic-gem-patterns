//  Created by Alexander Skorulis on 20/7/2024.

import VectorMath

struct ForceComponents {
    let towardsEnd: Vector2
    let towardsLine: Vector2
    
    var total: Vector2 {
        return towardsEnd + towardsLine
    }
}
