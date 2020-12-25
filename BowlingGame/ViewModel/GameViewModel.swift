//
//  GameViewModel.swift
//  BowlingGame
//
//  Created by George Muntean on 25/12/2020.
//

import UIKit

struct UIState {
    var ballFrame: CGRect
    let pinFrames: [CGRect]
}

class GameViewModel {
    let gameManager = GameManager()
    var uiState: Dynamic<UIState>
    var hittedPinsIds: Dynamic<Set<Int>>
    var round: Dynamic<Int>
    var roundInProgress = false
    var screenBounds: CGRect
    var initialBallFrame: CGRect
    var score: Dynamic<Int>
    
    func shootBawlingBall(directionVector: CGPoint) {
        if roundInProgress == true {
            return
        }
        roundInProgress = true
        var directionVector = directionVector
        
        //tune the vector a little bit to have a proper animation
        directionVector.x /= 20.0
        directionVector.y /= 20.0
        
        Timer.scheduledTimer(withTimeInterval: 0.01,
                             repeats: true, block: { timer in
                                var uiState = self.uiState.value
                                uiState.ballFrame = CGRect(x: uiState.ballFrame.minX + directionVector.x,
                                                           y: uiState.ballFrame.minY + directionVector.y,
                                                           width: uiState.ballFrame.width,
                                                           height: uiState.ballFrame.height)
                                
                                //check collisions
                                uiState.pinFrames.enumerated().forEach { index, pinFrame in
                                    if self.hittedPinsIds.value.contains(index) {
                                        return
                                    }
                                    if pinFrame.intersects(uiState.ballFrame) {
                                        self.hittedPinsIds.value.insert(index)
                                    }
                                }
                                
                                //check ball outside screen
                                if self.screenBounds.intersects(uiState.ballFrame) == false {
                                    
                                    //roll is over
                                    timer.invalidate()
                                    uiState.ballFrame = self.initialBallFrame
                                    self.nextRound()
                                }
                                
                                self.uiState.value = uiState
                             })
    }
    
    
    private func nextRound() {
        let currentRound = gameManager.round
        gameManager.roll(hittedPinsIds.value.count )
        round.value = gameManager.round
        roundInProgress = false
        
        //reset the pins only if the round changes
        if currentRound != round.value {
            hittedPinsIds.value = []
        }
        if gameManager.isGameCompleted == true {
            score.value = gameManager.score
        }
    }
    
    init(uiState: UIState, screenBounds: CGRect, initialBallFrame: CGRect) {
        self.uiState = Dynamic(uiState)
        self.hittedPinsIds = Dynamic([])
        self.screenBounds = screenBounds
        self.round = Dynamic(1)
        self.initialBallFrame = initialBallFrame
        self.score = Dynamic(0)
    }
}
