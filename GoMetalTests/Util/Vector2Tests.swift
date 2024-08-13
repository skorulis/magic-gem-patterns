//  Created by Alexander Skorulis on 13/8/2024.

import Foundation
import VectorMath
import XCTest
@testable import GoMetal

final class Vector2Tests: XCTestCase {
    
    func testDrag() {
        let input = Vector2(1, 1)
        XCTAssertEqual(
            input.drag(direction: .init(0, 1), pct: 1),
            .init(1, 0)
        )
        
        XCTAssertEqual(
            input.drag(direction: .init(0, -1), pct: 1),
            .init(1, 0)
        )
        
        XCTAssertEqual(
            input.drag(direction: .init(0, -1), pct: 0.5),
            .init(1, 0.5)
        )
        
    }
}
