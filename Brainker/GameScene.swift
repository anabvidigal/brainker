//
//  GameScene.swift
//  Brainker
//
//  Created by Ana Bittencourt Vidigal on 07/12/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: Player!
    var cam: SKCameraNode!
    var memorySpawner: MemorySpawner!
    var gameManager: GameManager!
    var gameTime: TimeInterval = 0
    var lastTime: TimeInterval = 0
    var remainingTime: Int = 6
    
    // 3 - guarda anotação da gameVC
    var gameViewControllerRef: GameViewController!
    
    override func didMove(to view: SKView) {
        // abriu o jogo, rodou
        
        cam = SKCameraNode()
        self.camera = cam
        
        let node = self.childNode(withName: "Player") as! SKSpriteNode
        
        player = Player(node: node)
        
        // Setup physicsWorld
        physicsWorld.gravity = CGVector(dx: 0, dy: -50)
        physicsWorld.contactDelegate = self
        
        // Informando: a gamescene tem um memory spawner
        memorySpawner = MemorySpawner(parent: self)
        gameManager = GameManager(memorySpawner: memorySpawner)
        
    }
    
    // função que conversa com a GameViewController
    // 4 - ouve a gameVC e anota
    func setGameVC(gameVC: GameViewController) {
        
        // fala pro gameManager o contato da gameVC
        gameManager.setGameVC(gameVC: gameVC)
        
        self.gameViewControllerRef = gameVC
    }
    
    
    func leftAction() {
        player.moveLeft()
    }
    
    func rightAction() {
        player.moveRight()
    }
    
    func leftStopAction() {
        player.stop()
        
    }
    
    func rightStopAction() {
        player.stop()
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        player.jump()

    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        player.land()
        
        if contact.bodyA.node?.name == "circle" || contact.bodyB.node?.name == "circle" {
            holdingMemory(type: .circle)
        } else if contact.bodyA.node?.name == "square" || contact.bodyB.node?.name == "square" {
            holdingMemory(type: .square)
        } else if contact.bodyA.node?.name == "triangle" || contact.bodyB.node?.name == "triangle" {
            holdingMemory(type: .triangle)
        } else if contact.bodyA.node?.name == "circle-receiver" || contact.bodyB.node?.name == "circle-receiver" {
            deliveryMemory(type: .circle)
        } else if contact.bodyA.node?.name == "square-receiver" || contact.bodyB.node?.name == "square-receiver" {
            deliveryMemory(type: .square)
        } else if contact.bodyA.node?.name == "triangle-receiver" || contact.bodyB.node?.name == "triangle-receiver" {
            deliveryMemory(type: .triangle)
        }
    }
    
    func holdingMemory(type: MemoryType) {
        memorySpawner.removeMemory(type: type)
        gameManager.holdingMemory(type: type)
    }
    
    func deliveryMemory(type: MemoryType) {
        gameManager.deliveryCheck(type: type)
    }
    
    func subtractSecond() {
        if remainingTime == 0 {
            return
        }
        
        remainingTime -= 1
        
        if remainingTime == 0 {
            print("Game Over")
            // chamar fase REM

        }
        
        if gameViewControllerRef != nil {
            gameViewControllerRef.displayTime(time: remainingTime)
        }
    }
        
    // Every tick
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // TEMPO
        
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        
        // deltaTime = tempo da chamada
        // currentTime = tempo de agora
        // lastTime = ultima vez que viu a hora
        
        let deltaTime = currentTime - lastTime
        lastTime = currentTime
        
        gameTime += deltaTime
        
        if gameTime > 1 {
            subtractSecond()
            gameTime = 0
        }
        
        // primeira vez: gameTime = 0, deltaTime = 0.16
        // gameTime = 0.16
        // segunda vez: 0.16 + 0.16
        // 0.32
        // terceira: 0.32 + 0.16
        // 0.48
        
        // TEMPO
        
        
        player.update()
        cam.position = player.node.position
        
        
    }
}
    

