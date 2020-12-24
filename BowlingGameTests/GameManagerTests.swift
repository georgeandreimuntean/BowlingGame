//
//  GameManagerTests.swift
//  GameManagerTests
//
//  Created by George Muntean on 24/12/2020.
//

import XCTest
@testable import BowlingGame

class GameManagerTests: XCTestCase {

    let sut = GameManager()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMaxScore() {
        (0..<10).forEach({ _ in
            sut.roll(10)
        })
        
        // Two Bonus rolls
        sut.roll(10)
        sut.roll(10)
        XCTAssertEqual(sut.score, 300, "The game score should be maximum in case of only  scoring strikes")
    }
    
    func testAlternatingHitsAndMissesWithNeitherStrikesNorSpares() {
        (0..<10).forEach({ _ in
            sut.roll(9)
            sut.roll(0)
        })
        XCTAssertEqual(sut.score, 90, "The game score should be correctly calculated")
    }
    
    func testScoringAllSpares() {
        (0..<10).forEach({ _ in
            sut.roll(5)
            sut.roll(5)
        })
        
        // One bonus roll
        sut.roll(5)
        XCTAssertEqual(sut.score, 150, "The game score should be half of the maximum possible in case of scorring exactly 5 points on each hit")
    }
    
    
    func testScoringMaximumAllSpares() {
        (0..<10).forEach({ _ in
            sut.roll(9)
            sut.roll(1)
        })
        
        // One bonus roll
        sut.roll(10)
        
        XCTAssertEqual(sut.score, 191, "The game score should be correctly calculated")
    }
}
