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

    var gameSceneRef: GameScene!
    // 1, variavel
    
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var square: UIImageView!
    @IBOutlet weak var triangle: UIImageView!
        
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            // Load the SKScene from 'GameScene.sks'
            gameSceneRef = SKScene(fileNamed: "GameScene") as? GameScene
            // Set the scale mode to scale to fit the window
            gameSceneRef.scaleMode = .aspectFill
                
            
            // Present the scene
            view.presentScene(gameSceneRef)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            displayScore(newScore: 0)
        }
        
    }

    
    // a gameViewController tem uma variavel da classe GameScene
    // essa função passa a scene
    // 2
    override func viewDidAppear(_ animated: Bool) {
        // manda a própria referencia (gamevc) para a gameScene
        gameSceneRef.setGameVC(gameVC: self)
    }
    
    
    @IBAction func leftAction(_ sender: Any) {
        gameSceneRef.leftAction()
    }
    
    
    @IBAction func rightAction(_ sender: Any) {
        gameSceneRef.rightAction()
    }
    
    
    @IBAction func leftStopAction(_ sender: Any) {
        gameSceneRef.leftStopAction()
    }
    
    
    @IBAction func rightStopAction(_ sender: Any) {
        gameSceneRef.rightStopAction()
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
    
    func displayTime(time: Int) {
        timeLabel.text = "Time: \(time)s"
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
