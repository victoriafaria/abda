//
//  IntroSceneTwo.swift
//  abda
//
//  Created by Victoria Faria on 29/11/21.
//

import SpriteKit

class IntroSceneTwo: SKScene {

    private var nextButton: SKSpriteNode?

    override func didMove(to view: SKView) {

        // show nextButton
        self.nextButton = self.childNode(withName: "nextButton") as? SKSpriteNode
    }


    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in:self)
            if let nextButton = self.nextButton, nextButton.contains(location) {
                 let changeScene = SKAction.run {

                    if let scene = IntroSceneThree (fileNamed: "IntroSceneThree"){
                        scene.scaleMode = .aspectFill

                        self.view?.ignoresSiblingOrder = false
                        self.view?.presentScene(scene)
                    }
                }
                let sequence = SKAction.sequence([SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false),SKAction.wait(forDuration: 0.2), changeScene])

                nextButton.run(sequence)
            }
        }
    }
}
