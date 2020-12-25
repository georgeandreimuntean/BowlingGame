# BowlingGame
A bowling game for iOS, written with SwiftUI, and MVVM architecture. A TDD Aproach is used in the development

## Installation
Open <i>BowlingGame.xcodeproj</i>

## Project description
MVVM Architectural pattern was chosen in order to benefit in the future implementations on a decoupled code, with separation of concerns
MVVM Aproach was handled through binding between ViewModel and View, using the custom helper class <i> Dynamic.swift </i> 
No Massive View Controller issues shoudl appear
The view controller lifecycle is completly separated from the game's business logic, so unit tests can be written properly as the View Model has no dependencies to the View Controller

## Main classes

### GameViewModel

Contains the business logic for the game, and it's coupled with GameManager which was designed as a service in the code. 
It mainly processes animations and ui actions and uses GameManager service to process the rules of the game.
Unit tests are currently covering basic scenarios, and can be improved with the whole game flow

### GameManager

A service that provides the game rules and processes them. It's also computing the final score.
Unit tests are covering the main scenarios regarding the game-play, and the computation of the score
