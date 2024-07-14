//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import XCTest
@testable import GoMetal

final class LinePatternTests: XCTestCase {
    
    func testPosition() {
        let pattern = LinePattern()
        XCTAssertEqual(pattern.position(time: 0), .init(x: 0, y: -1))
        XCTAssertEqual(pattern.position(time: 1), .init(x: 0, y: 1))
        XCTAssertEqual(pattern.position(time: 0.5), .init(x: 0, y: 0))
    }
    
    func testForce() {
        let pattern = LinePattern()
        XCTAssertEqual(pattern.force(at: .init(x: 0, y: 0)), .init(width: 0, height: 0))
        XCTAssertEqual(pattern.force(at: .init(x: 0, y: 1)), .init(width: 0, height: 0))
        XCTAssertEqual(pattern.force(at: .init(x: 1, y: 0)), .init(width: 0, height: 0))
        XCTAssertEqual(pattern.force(at: .init(x: 0.5, y: 0)), .init(width: -0.25, height: 0))
        XCTAssertEqual(pattern.force(at: .init(x: -0.5, y: 0)), .init(width: 0.25, height: 0))
    }
}
