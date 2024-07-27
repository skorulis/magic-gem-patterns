//  Created by Alexander Skorulis on 20/7/2024.

import VectorMath

struct ForceComponents: Equatable {
    let towardsEnd: Vector2
    let towardsLine: Vector2
    
    var total: Vector2 {
        return towardsEnd + towardsLine
    }
    
    func cleaned() -> ForceComponents {
        return .init(
            towardsEnd: towardsEnd.cleaned(),
            towardsLine: towardsLine.cleaned()
        )
    }
}
