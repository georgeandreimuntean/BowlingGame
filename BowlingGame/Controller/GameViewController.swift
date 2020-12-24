//
//  ViewController.swift
//  BowlingGame
//
//  Created by George Muntean on 24/12/2020.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var panGestureRecognizer: UIGestureRecognizer!
    
    @IBAction func didSwipeBowlingBall(sender: UIPanGestureRecognizer) {
        let direction = sender.translation(in: self.view)
        viewModel.shootBawlingBall(direction: direction)
        
        //remove the gesture recognizer
        panGestureRecognizer.view?.removeGestureRecognizer(panGestureRecognizer)
    }
    
    let viewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
    }
    
    func setupBinding() {
        viewModel.hittedBalls.bind { ballsIndices in
            print("cacatu vietii")
        }
    }
}

