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
    
    func setGameVC(gameVC: GameViewController) {
        gameManager.setGameVC(gameVC: gameVC)
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
        
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered - Every tick!!!
        player.update()
        cam.position = player.node.position
        
    }
}
    

