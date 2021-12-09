//
//  Player.swift
//  Brainker
//
//  Created by Ana Bittencourt Vidigal on 07/12/21.
//

import Foundation
import SpriteKit

class Player {
    
    private (set) var node: SKSpriteNode
    private var jumpForce = CGFloat(2000)
    private var moveSpeed = CGFloat(10000)
    private var jumpsAmount = 2
    
    private var moveStatus: MoveStatus = .idle
    private var remainingJumps = 0
    
    
    let charAnimation: SKAction
    
    var textures:[SKTexture] = []
    
    init (node: SKSpriteNode) {
        self.node = node
        
        // Informing which objects to check
        node.physicsBody?.categoryBitMask = Masks.playerMask
        node.physicsBody?.contactTestBitMask = Masks.memoryMask
        
        // Animating sprites
        for i in 0...5 {
            textures.append(SKTexture(imageNamed:"char\(i)"))
        }
        
        let playerAnimation = SKAction.animate(with: textures,timePerFrame:0.1)
        charAnimation = SKAction.repeatForever(playerAnimation)
                
    }
    
    func jump() {
        if remainingJumps > 0 {
            node.physicsBody?.velocity.dy = jumpForce
            remainingJumps -= 1
        }
    }
    
    func moveLeft() {
        moveStatus = .moveLeft
        node.xScale = -1
        node.run(charAnimation)
    }
    
    func moveRight() {
        moveStatus = .moveRight
        node.xScale = 1
        node.run(charAnimation)

    }
    
    func stop() {
        moveStatus = .idle
        node.removeAllActions()
        node.texture = textures[0]

    }
    
    func update() {
        // 60 fps
        
        switch moveStatus {
        case .idle:
            break
        case .moveRight:
            node.physicsBody?.applyForce(CGVector(dx: moveSpeed, dy: 0))
        case .moveLeft:
            node.physicsBody?.applyForce(CGVector(dx: -moveSpeed, dy: 0))

        }
    }
    
    // Jumping
    
    func land() {
        remainingJumps = jumpsAmount
    }
    
    enum MoveStatus {
        case idle
        case moveRight
        case moveLeft
    }
    
}
