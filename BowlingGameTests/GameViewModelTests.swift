//
//  GameViewModelTests.swift
//  BowlingGameTests
//
//  Created by George Muntean on 25/12/2020.
//

import Foundation


import XCTest
@testable import BowlingGame

class GameViewModelTests: XCTestCase {

    var sut: GameViewModel!
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNextRoundWithStrike() {
        //setup all the pins and the ball in the same position, and expect to have a strike and jump to the next round
        let someRect = CGRect(x: 0, y: 0, width: 10, height: 10)
        let uiState = UIState(ballFrame: someRect,
                              pinFrames: Array(repeating: someRect, count: 10))
        sut = GameViewModel(uiState: uiState,
                            screenBounds: someRect,
                            initialBallFrame: someRect)
        
        XCTAssertEqual(sut.gameManager.round, 1)
        sut.shootBawlingBall(directionVector: CGPoint(x:0, y:100))
        
        //give some time for the rendering
        let processExpectation = expectation(description: "processExpectation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertEqual(self.sut.gameManager.round, 2)
            processExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
       
    }
    
    func testNextRoundWithoutStrike() {
        //setup all the pins, but one in the same position. expecting to have non strike
        let someRect = CGRect(x: 0, y: 0, width: 10, height: 10)
        let someOtherRect = CGRect(x: 0, y: -1000, width: 10, height: 10)
        let uiState = UIState(ballFrame: someRect,
                              pinFrames: Array(repeating: someRect, count: 9) + [someOtherRect])
        sut = GameViewModel(uiState: uiState,
                            screenBounds: someRect,
                            initialBallFrame: someRect)
        
        XCTAssertEqual(sut.gameManager.round, 1)
        sut.shootBawlingBall(directionVector: CGPoint(x:0, y:100))
        
        //give some time for the rendering
        let processExpectation = expectation(description: "processExpectation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertEqual(self.sut.gameManager.round, 1)
            processExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
