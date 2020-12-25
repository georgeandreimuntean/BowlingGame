//
//  ViewController.swift
//  BowlingGame
//
//  Created by George Muntean on 24/12/2020.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet var panGestureRecognizer: UIGestureRecognizer!
    @IBOutlet var bowlingPins: [UIView]!
    @IBOutlet var bowlingBall: UIView!
    @IBOutlet var roundLabel: UILabel!
    
    @IBAction func didSwipeBowlingBall(sender: UIPanGestureRecognizer) {
        if sender.state == .ended {
            viewModel.shootBawlingBall(directionVector: sender.translation(in: self.view))
        }
    }
    
    private var viewModel: GameViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Setup the ViewModel after the view has properly layout it's subview, to obtain the proper coordinates
        setupViewModel()
        setupBinding()
    }
    
    private func setupBinding() {
        viewModel.uiState.bind { [weak self] uistate in
            self?.bowlingBall.frame = uistate.ballFrame
        }
        
        viewModel.hittedPinsIds.bind { [weak self] pinIds in
            self?.bowlingPins.forEach { bowlingPin in
                bowlingPin.alpha = 1.0
            }
            pinIds.forEach { pinId in
                UIView.animate(withDuration: 1.0, animations: {
                    self?.bowlingPins[pinId].alpha = 0
                    })
                
            }
        }
        
        viewModel.round.bind { [weak self] round in
            self?.roundLabel.text = "Round \(round)"
        }
        
        viewModel.score.bind { [weak self] score in
            let alert = UIAlertController(title: "Game Over", message: "Score: \(score)", preferredStyle: .alert)
            self?.present(alert, animated: true)
        }
    }
    
    private func setupViewModel() {
        //setup view model with the proper coordinates, generated in the coordinates of the view controller's view 
        let uiState = UIState(ballFrame: bowlingBall.frame,
                              pinFrames: bowlingPins.map{self.view.convert($0.frame, from: $0.superview)})
        viewModel = GameViewModel(uiState: uiState,
                                  screenBounds: view.bounds,
                                  initialBallFrame: bowlingBall.frame)
    }
}

