//
//  MemorySpawner.swift.swift
//  Brainker
//
//  Created by Ana Bittencourt Vidigal on 08/12/21.
//

import Foundation
import SpriteKit

class MemorySpawner {
    
    private var parent: SKNode
    
    private var circleMemory: Memory
    private var squareMemory: Memory
    private var triangleMemory: Memory
    
    private var circleReceiver: MemoryReceiver
    private var squareReceiver: MemoryReceiver
    private var triangleReceiver: MemoryReceiver
    
    // Initializing memories, placing them
    // I will try randomizing this
    
    init (parent: SKNode) {
        self.parent = parent
        
        circleMemory = Memory(type: .circle, parent: parent, position: CGPoint(x: -70, y: -80))
        squareMemory = Memory(type: .square, parent: parent, position: CGPoint(x: 360, y: -200))
        triangleMemory = Memory(type: .triangle, parent: parent, position: CGPoint(x: 160, y: -65))
        
        circleReceiver = MemoryReceiver(type: .circle, position: CGPoint(x: -580, y: -160), parent: parent)
        squareReceiver = MemoryReceiver(type: .square, position: CGPoint(x: -780, y: -160), parent: parent)
        triangleReceiver = MemoryReceiver(type: .triangle, position: CGPoint(x: -640, y: -160), parent: parent)

    }
    
    func removeMemory(type: MemoryType) {
        
        switch type {
        case .circle:
            circleMemory.remove()
        case .square:
            squareMemory.remove()
        case .triangle:
            triangleMemory.remove()
        }
    }
    
    func delivery (type: MemoryType) {
        switch type {
        case .circle:
            circleMemory.replace(parent: parent, position: getRandomPosition())
            circleReceiver.replace(parent: parent, position: getRandomPosition())
            
        case .square:
            squareMemory.replace(parent: parent, position: getRandomPosition())
            squareReceiver.replace(parent: parent, position: getRandomPosition())
        case .triangle:
            triangleMemory.replace(parent: parent, position: getRandomPosition())
            triangleReceiver.replace(parent: parent, position: getRandomPosition())
        }
    }
    
    private func getRandomPosition() -> CGPoint {
        let x = CGFloat.random(in: -960...320)
        let y = CGFloat.random(in: -210...0)
        return CGPoint(x: x, y: y)
        
    }
    
}
