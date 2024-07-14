//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import XCTest
@testable import GoMetal

final class PatternSpaceTests: XCTestCase {
    
    func testScreenSpaceConversion() {
        let space = PatternSpace(screenSize: .init(width: 100, height: 200))
        
        XCTAssertEqual(
            space.toScreenSpace(point: .zero),
            .init(x: 50, y: 100)
        )
        
        XCTAssertEqual(
            space.toScreenSpace(point: .init(x: 1, y: 1)),
            .init(x: 100, y: 0)
        )
        
        XCTAssertEqual(
            space.toScreenSpace(point: .init(x: -1, y: -1)),
            .init(x: 0, y: 200)
        )
        
        XCTAssertEqual(
            space.toScreenSpace(point: .init(x: 0.5, y: -0.5)),
            .init(x: 75, y: 150)
        )
    }
    
    func testPatternSpaceConversion() {
        let space = PatternSpace(screenSize: .init(width: 100, height: 200))
        XCTAssertEqual(
            space.toPatternSpace(point: .zero),
            .init(x: -1, y: 1)
        )
        
        XCTAssertEqual(
            space.toPatternSpace(point: .init(x: 100, y: 200)),
            .init(x: 1, y: -1)
        )
        
        XCTAssertEqual(
            space.toPatternSpace(point: .init(x: 50, y: 50)),
            .init(x: 0, y: 0.5)
        )
    }
}
