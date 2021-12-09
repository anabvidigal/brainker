//
//  GameViewController.swift
//  Brainker
//
//  Created by Ana Bittencourt Vidigal on 07/12/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var scene: GameScene!
    
    
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var square: UIImageView!
    @IBOutlet weak var triangle: UIImageView!
        
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            // Load the SKScene from 'GameScene.sks'
            scene = SKScene(fileNamed: "GameScene") as? GameScene
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
                
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            displayScore(newScore: 0)
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        scene.setGameVC(gameVC: self)
    }
    
    @IBAction func leftAction(_ sender: Any) {
        scene.leftAction()
    }
    
    
    @IBAction func rightAction(_ sender: Any) {
        scene.rightAction()
    }
    
    
    @IBAction func leftStopAction(_ sender: Any) {
        scene.leftStopAction()
    }
    
    
    @IBAction func rightStopAction(_ sender: Any) {
        scene.rightStopAction()
    }
    
    
    func displayMemory(type: MemoryType, hide: Bool) {
        switch type {
        case .circle:
            circle.isHidden = hide
        case .square:
            square.isHidden = hide
        case .triangle:
            triangle.isHidden = hide
        }
    }
   
    
    func displayScore(newScore: Int) {
        scoreLabel.text = "Score: \(newScore)"
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
