//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import XCTest
@testable import GoMetal

final class CirclePatternTests: XCTestCase {
    
    func testCircleForce() {
        let pattern = CirclePattern()
        
        XCTAssertEqual(
            pattern.force(at: .zero),
            .init(towardsEnd: .zero, towardsLine: .init(1, 0))
        )
        XCTAssertEqual(
            pattern.force(at: .init(1, 0)).cleaned(),
            .init(towardsEnd: .init(0, 1), towardsLine: .init(0, 1))
        )
        
        XCTAssertEqual(
            pattern.force(at: .init(0, 1)).cleaned(),
            .init(towardsEnd: .init(-1, 0), towardsLine: .init(-1, 0))
        )
    }
    
    func testTimeToPosition() {
        let pattern = CirclePattern()
        XCTAssertEqual(
            pattern.position(time: 0),
            .init(1, 0)
        )
        
        XCTAssertEqual(
            pattern.position(time: 0.25).cleaned(),
            .init(0, 1)
        )
        
        XCTAssertEqual(
            pattern.position(time: 0.5).cleaned(),
            .init(-1, 0)
        )
        
        XCTAssertEqual(
            pattern.position(time: 0.75).cleaned(),
            .init(0, -1)
        )
        
        XCTAssertEqual(
            pattern.position(time: 1).cleaned(),
            .init(1, 0)
        )
        
    }
    
    func testPositionToTime() {
        let pattern = CirclePattern()
        XCTAssertEqual(
            pattern.time(position: .init(1, 0)),
            0
        )
        
        XCTAssertEqual(
            pattern.time(position: .init(0, 1)),
            0.25,
            accuracy: 0.000001
        )
        
        XCTAssertEqual(
            pattern.time(position: .init(-1, 0)),
            0.5,
            accuracy: 0.000001
        )
        
        XCTAssertEqual(
            pattern.time(position: .init(0, -1)),
            0.75,
            accuracy: 0.000001
        )
        
        XCTAssertEqual(
            pattern.time(position: .init(0.95, -0.3)),
            0.95,
            accuracy: 0.1
        )
    }
    
}

