//
//  Receiver.swift
//  Brainker
//
//  Created by Ana Bittencourt Vidigal on 08/12/21.
//

import Foundation
import SpriteKit

class MemoryReceiver {
    
    private var node: SKSpriteNode
    private var type: MemoryType
    
    // Initializing memory receiver nodes, sprites and names
    init (type: MemoryType, position: CGPoint, parent: SKNode) {
        self.type = type
        switch type {
        case .circle:
            self.node = SKSpriteNode(imageNamed: "circle-receiver")
            self.node.name = "circle-receiver"
        case .square:
            self.node = SKSpriteNode(imageNamed: "square-receiver")
            self.node.name = "square-receiver"
        case .triangle:
            self.node = SKSpriteNode(imageNamed: "triangle-receiver")
            self.node.name = "triangle-receiver"
            
        }
        
        // Scaling the node down
        self.node.setScale(0.1)
        
        parent.addChild(self.node)
        
        // Attributing physics and masks
        let body = SKPhysicsBody(circleOfRadius: 50)
        body.categoryBitMask = Masks.memoryMask
        body.contactTestBitMask = Masks.playerMask
        body.collisionBitMask = 0
        body.affectedByGravity = false
        
        // Applying body attributes to node
        self.node.physicsBody = body
        
        // Setting the node's position !!
        self.node.position = position
    }
    

    // Attention: See how remove and replace are being used
    // Remove function
    func remove() {
        node.removeFromParent()
    }
    
    // Replace function
    func replace(parent: SKNode, position: CGPoint) {
        DispatchQueue.main.async {
            self.node.position = position
        }
    }
}
