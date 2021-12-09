//
//  GameManager.swift
//  Brainker
//
//  Created by Ana Bittencourt Vidigal on 08/12/21.
//

import Foundation

class GameManager {
    
    private var isCirclePicked = false
    private var isSquarePicked = false
    private var isTrianglePicked = false
    
    private var memorySpawner: MemorySpawner
    
    private var gameVC: GameViewController!
    
    var gameScore = 0
    

    
    init(memorySpawner: MemorySpawner) {
        self.memorySpawner = memorySpawner
    }

    func setGameVC(gameVC: GameViewController) {
        self.gameVC = gameVC
    }
    
   
    func holdingMemory(type: MemoryType) {
        switch type {
        case .circle:
            isCirclePicked = true
            gameVC.displayMemory(type: .circle, hide: false)
        case .square:
            isSquarePicked = true
            gameVC.displayMemory(type: .square, hide: false)

        case .triangle:
            isTrianglePicked = true
            gameVC.displayMemory(type: .triangle, hide: false)
        }

    }
    
    func deliveryCheck(type: MemoryType) {
        switch type {
        case .circle:
            if isCirclePicked {
                delivery(type: .circle)
                isCirclePicked = false
                gameVC.displayMemory(type: .circle, hide: true)
                gameScore += 10
                gameVC.displayScore(newScore: gameScore)
            }
        case .square:
            if isSquarePicked {
                delivery(type: .square)
                isSquarePicked = false
                gameVC.displayMemory(type: .square, hide: true)
                gameScore += 10
                gameVC.displayScore(newScore: gameScore)

            }
        case .triangle:
            if isTrianglePicked {
                delivery(type: .triangle)
                isTrianglePicked = false
                gameVC.displayMemory(type: .triangle, hide: true)
                gameScore += 10
                gameVC.displayScore(newScore: gameScore)

            }
        }
    }
    
    func delivery(type: MemoryType) {
        print("Marcou ponto")
        memorySpawner.delivery(type: type)
    }
    
    // Pontuação
    
    // Timer
    
    // Momentos da fase (REM, Amanhecendo)
    
}
