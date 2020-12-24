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
        (0..<9).forEach({ _ in
            let frame = GameManager.Frame(hits: [10,0])
            sut.roll(frame: frame)
        })
        
        // Final roll - The final bonus hits are included in the roll
        let frame = GameManager.Frame(hits: [10,10,10])
        sut.roll(frame: frame)
        
        XCTAssertEqual(sut.score, 300, "The game score should be maximum in case of only  scoring strikes")
    }
    
    func testMaxScoreWithNoStrikesNorSpares() {
        (0..<10).forEach({ _ in
            let frame = GameManager.Frame(hits: [9,0])
            sut.roll(frame: frame)
        })
        XCTAssertEqual(sut.score, 90, "The game score should be correctly calculated")
    }
    
    func testScoringOnlyFivePointsWithMaxSpares() {
        (0..<9).forEach({ _ in
            let frame = GameManager.Frame(hits: [5,5])
            sut.roll(frame: frame)
        })
        
        // Final roll
        let frame = GameManager.Frame(hits: [5,5,5])
        sut.roll(frame: frame)
        
        XCTAssertEqual(sut.score, 150, "The game score should be half of the maximum possible in case of scorring exactly 5 points on each hit")
    }
    
    func testMaxScoreWithMaxSpares() {
        (0..<9).forEach({ _ in
            let frame = GameManager.Frame(hits: [9,1])
            sut.roll(frame: frame)
        })
        
        // Final roll
        let frame = GameManager.Frame(hits: [9,1,10])
        sut.roll(frame: frame)
        
        XCTAssertEqual(sut.score, 191, "The game score should be correctly calculated")
    }
}
