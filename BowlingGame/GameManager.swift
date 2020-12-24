//
//  GameManager.swift
//  BowlingGame
//
//  Created by George Muntean on 24/12/2020.
//

import Foundation

/// 🎳 The business logic for the bowling game
class GameManager {

    private var frames = [Frame]()
    
    // TODO: Compute the score based on the frames
    var score: Int {
        return 0
    }
    
    struct Frame {
        let hits: [Int]
    }
    
    // TODO: finish implementation of the roll method
    func roll(frame: Frame) {
        frames.append(frame)
    }
        
}
