//
//  GameViewModel.swift
//  BowlingGame
//
//  Created by George Muntean on 25/12/2020.
//

import UIKit

class GameViewModel {
    let gameManager = GameManager()
    var hittedBalls: Dynamic<[Int]> = Dynamic([])
    func shootBawlingBall(direction: CGPoint) {
        hittedBalls.value = [1]
    }
}
