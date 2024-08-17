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
    
    func testCentre() {
        let p1 = Vector2.center(points: [
            .init(0, 1),
            .init(0, -1)
        ])
        XCTAssertEqual(p1, .init(0, 0))
        
        let p2 = Vector2.center(points: [
            .init(0, 1),
            .init(1, 0.5)
        ])
        XCTAssertEqual(p2, .init(0.5, 0.75))
    }
    
    func testBounds() {
        let (min1, max1) = Vector2.bounds(points: [
            .init(0, 1),
            .init(0, -1)
        ])
        XCTAssertEqual(min1, .init(0, -1))
        XCTAssertEqual(max1, .init(0, 1))
        
        let (min2, max2) = Vector2.bounds(points: [
            .init(-5, 1),
            .init(-2, 2),
            .init(-1, 3),
        ])
        XCTAssertEqual(min2, .init(-5, 1))
        XCTAssertEqual(max2, .init(-1, 3))
    }
}
