//
//  GameManager.swift
//  BowlingGame
//
//  Created by George Muntean on 24/12/2020.
//

import Foundation

private let maxPoints = 10

struct Frame {
    enum FrameType {
        case normal
        case spare
        case strike
    }
    
    var rolls = [Int]()
    var isLastFrame = false
    
    var frameScore: Int {
        return rolls.reduce(0, +)
    }
    
    // Informs the game engine that the frame is closed, and if necessary it can jump to the next one
    var isFrameCompleted: Bool {
        if isLastFrame {
            switch frameType {
            case .spare, .strike:
                return rolls.count >= 3
            default:
                break
            }
        } else {
            switch frameType {
            case .strike:
                return rolls.count >= 1
            default:
               break
            }
        }
        
        return rolls.count >= 2
    }
    
    var frameType : FrameType {
        if rolls.first == maxPoints {
            return .strike
        }
        if frameScore == maxPoints {
            return .spare
        }
        return .normal
    }
    
    func computeFrameScore(nextFrames: [Frame]) -> Int {
        let nextRolls = nextFrames.flatMap { $0.rolls }
        switch frameType {
        case .normal:
            return frameScore
        case .spare:
            return frameScore + (nextRolls.first ?? 0)
        case .strike:
            return frameScore + (nextRolls.first ?? 0) + (nextRolls[safe: 1] ?? 0)
        }
    }
}

/// 🎳 The business logic for the bowling game
class GameManager {
    private var frames = [Frame]()
    
    var score: Int {
        var score = 0
        for index in 0..<frames.count {
            score += frames[index].computeFrameScore(nextFrames: Array(frames.suffix(from: index+1)))
        }
        return score
    }
    
    private var ongoingFrame = Frame()
    var round: Int {
        return frames.count + 1
    }
    var isGameCompleted: Bool {
        return frames.count == 10
    }
    
    func roll(_ points: Int) {
        ongoingFrame.rolls.append(points)
        //If we reach the maximum number of rolls per frame we create a new one
        if ongoingFrame.isFrameCompleted {
            frames.append(ongoingFrame)
            ongoingFrame = Frame()
            ongoingFrame.isLastFrame = (frames.count >= 9)
            return
        }
        
    }
    
}
