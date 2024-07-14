//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import XCTest
@testable import GoMetal

final class CirclePatternTests: XCTestCase {
    
    func testCircleForce() {
        let pattern = CirclePattern()
        
        XCTAssertEqual(pattern.force(at: .zero), .zero)
    }
    
}

