//  Created by Alexander Skorulis on 14/7/2024.

import Foundation
import XCTest
@testable import GoMetal

final class NormalizedSpaceTests: XCTestCase {
    
    func testScreenSpaceConversion() {
        let space = NormalizedSpace(canvasSize: .init(width: 100, height: 200))
        
        XCTAssertEqual(
            space.toScreenSpace(point: .zero),
            .init(50, 100)
        )
        
        XCTAssertEqual(
            space.toScreenSpace(point: .init(1, 1)),
            .init(100, 0)
        )
        
        XCTAssertEqual(
            space.toScreenSpace(point: .init(-1, -1)),
            .init(0, 200)
        )
        
        XCTAssertEqual(
            space.toScreenSpace(point: .init(0.5, -0.5)),
            .init(75, 150)
        )
    }
    
    func testNormalSpaceConversion() {
        let space = NormalizedSpace(canvasSize: .init(width: 100, height: 200))
        XCTAssertEqual(
            space.toNormalSpace(point: .zero),
            .init(-1, 1)
        )
        
        XCTAssertEqual(
            space.toNormalSpace(point: .init(100, 200)),
            .init(1, -1)
        )
        
        XCTAssertEqual(
            space.toNormalSpace(point: .init(50, 50)),
            .init(0, 0.5)
        )
    }
    
    func testScreenSpaceSizeConversion() {
        let space = NormalizedSpace(canvasSize: .init(width: 100, height: 200))
        XCTAssertEqual(
            space.toScreenSpace(size: .zero),
            .zero
        )
        
        XCTAssertEqual(
            space.toScreenSpace(size: .init(1, -1)),
            .init(50, 100)
        )
        
        XCTAssertEqual(
            space.toScreenSpace(size: .init(-1, 1)),
            .init(-50, -100)
        )
        
        XCTAssertEqual(
            space.toScreenSpace(size: .init(0.5, 0.5)),
            .init(25, -50)
        )
    }
}
