//  Created by Alexander Skorulis on 16/8/2024.

@testable import GoMetal
import XCTest
import VectorMath

final class SpellShapeMatcherTests: XCTestCase {
    
    private let points2Line: [Vector2] = [
        .init(0, 1),
        .init(0, -1)
    ]
    private let points3Line: [Vector2] = [
        .init(0, 1),
        .init(0, -1),
        .init(0, 0),
    ]
    private let points4Diamond: [Vector2] = [
        .init(0, 1),
        .init(1, 0),
        .init(0, -1),
        .init(-1, 0),
    ]
    
    private let sut = SpellShapeMatcher()
    
    func testCircleDeviance() {
        XCTAssertEqual(sut.deviance(shape: .ball, points: points2Line), 0)
        
        let points2: [Vector2] = [
            .init(0, 1),
            .init(1, -1)
        ]
        XCTAssertEqual(sut.deviance(shape: .ball, points: points2), 0)
        XCTAssertEqual(sut.deviance(shape: .ball, points: points4Diamond), 0)
        XCTAssertEqual(sut.deviance(shape: .ball, points: points3Line), 1)
    }
    
    func testLineDeviance() {
        XCTAssertEqual(sut.deviance(shape: .beam, points: points2Line), 0)
        XCTAssertEqual(sut.deviance(shape: .beam, points: points4Diamond), 2)
        XCTAssertEqual(sut.deviance(shape: .beam, points: points3Line), 0)
    }

    func testBeamMatch() {
        XCTAssertEqual(sut.bestMatch(points: points2Line), .beam)
        XCTAssertEqual(sut.bestMatch(points: points3Line), .beam)
    }
    
    func testBallMatch() {
        XCTAssertEqual(sut.bestMatch(points: points4Diamond), .ball)
    }
}

extension SpellShapeMatcher {
    func deviance(shape: SpellShape, points: [Vector2]) -> Float {
        var context = Context(points: points)
        return deviance(shape: shape, context: &context)
    }
}
