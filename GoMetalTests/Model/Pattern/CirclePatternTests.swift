//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import XCTest
@testable import GoMetal

final class CirclePatternTests: XCTestCase {
    
    func testCircleForce() {
        let pattern = CirclePattern()
        
        XCTAssertEqual(pattern.force(at: .zero), .zero)
        XCTAssertEqual(
            pattern.force(at: .init(1, 0)).cleaned(),
            .init(0, 1)
        )
        
        XCTAssertEqual(
            pattern.force(at: .init(0, 1)).cleaned(),
            .init(-1, 0)
        )
    }
    
}

