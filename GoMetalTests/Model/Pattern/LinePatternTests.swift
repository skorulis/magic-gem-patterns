//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import XCTest
@testable import GoMetal

final class LinePatternTests: XCTestCase {
    
    func testPosition() {
        let pattern = LinePattern()
        XCTAssertEqual(pattern.position(time: 0), .init(0, -1))
        XCTAssertEqual(pattern.position(time: 1), .init(0, 1))
        XCTAssertEqual(pattern.position(time: 0.5), .init(0, 0))
    }
    
    func testForce() {
        let pattern = LinePattern()
        XCTAssertEqual(pattern.lineForce(at: .init(0, 0)), .init(0, 0))
        XCTAssertEqual(pattern.lineForce(at: .init(0, 1)), .init(0, 0))
        XCTAssertEqual(pattern.lineForce(at: .init(1, 0)), .init(0, 0))
        XCTAssertEqual(pattern.lineForce(at: .init(0.5, 0)), .init(-0.25, 0))
        XCTAssertEqual(pattern.lineForce(at: .init(-0.5, 0)), .init(0.25, 0))
    }
}
