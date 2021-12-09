//
//  Memory.swift
//  Brainker
//
//  Created by Ana Bittencourt Vidigal on 07/12/21.
//

import Foundation
import SpriteKit


class Memory {
    
    private var node: SKSpriteNode
    private var type: MemoryType
    
    init (type: MemoryType, parent: SKNode, position: CGPoint) {
        self.type = type
        
        switch type {
        case .circle:
            self.node = SKSpriteNode(imageNamed: "circle-item")
            self.node.name = "circle"
            
        case .square:
            self.node = SKSpriteNode(imageNamed: "square-item")
            self.node.name = "square"

        case .triangle:
            self.node = SKSpriteNode(imageNamed: "triangle-item")
            self.node.name = "triangle"
        }
        
        self.node.setScale(CGFloat(0.1))
        self.node.position = position
        
        let body = SKPhysicsBody(circleOfRadius: 25)
        body.affectedByGravity = false
        
        body.categoryBitMask = Masks.memoryMask
        body.contactTestBitMask = Masks.playerMask
        body.collisionBitMask = 0
        
        self.node.physicsBody = body
        
        parent.addChild(self.node)
    }
    
    func remove() {
        node.removeFromParent()
    }
    
    func replace(parent: SKNode, position: CGPoint) {
        parent.addChild(node)
        DispatchQueue.main.async {
            self.node.position = position
        }
    }
}


 

