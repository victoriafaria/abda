//
//  GameScene.swift
//  abda
//
//  Created by Victoria Faria on 28/11/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    private var startButton: SKSpriteNode?
    
    override func didMove(to view: SKView) {

        // show start
        self.startButton = self.childNode(withName: "startButton") as? SKSpriteNode


    }//end didMove


    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in:self)
            if let startButton = self.startButton, startButton.contains(location) {
                 let changeScene = SKAction.run {

                    if let scene = IntroSceneOne (fileNamed: "IntroSceneOne"){
                        scene.scaleMode = .aspectFill

                        self.view?.ignoresSiblingOrder = false
                        self.view?.presentScene(scene)
                    }
                }
                let sequence = SKAction.sequence([SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false),SKAction.wait(forDuration: 0.2), changeScene])

                startButton.run(sequence)
            }
        }
    }
    

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
