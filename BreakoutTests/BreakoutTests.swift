//
//  BreakoutTests.swift
//  BreakoutTests
//
//  Created by Samuel K on 5/6/21.
//

import XCTest
import CoreGraphics
@testable import Breakout

class BreakoutTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testVectorLength() throws {
        let vector = CGVector(dx: 1, dy: 0)
        XCTAssertEqual(VectorMath.length(vector: vector), 1)
    }
    
    func testVectorAngle() throws {
        let vector = CGVector(dx: 1, dy: 0)
        XCTAssertEqual(VectorMath.degrees(vector: vector), 0)
        
        let vector2 = CGVector(dx: 0, dy: 1)
        XCTAssertEqual(VectorMath.degrees(vector: vector2), 90)
    }
}
