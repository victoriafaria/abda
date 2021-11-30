//
//  IntroSceneTwo.swift
//  abda
//
//  Created by Victoria Faria on 29/11/21.
//

import SpriteKit

class IntroSceneThree: SKScene {

    private var introLabel: SKLabelNode?
    private var playButton: SKSpriteNode?

    override func didMove(to view: SKView) {

        // show the typing
        // ps: Just for less texts
        self.introLabel = self.childNode(withName: "introLabel") as? SKLabelNode
        setTyping(text: "Abda precisa de sua ajuda...")

        // show playButton
        self.playButton = self.childNode(withName: "playButton") as? SKSpriteNode
    }


    func setTyping(text: String, characterDelay: TimeInterval = 5.0) {
        introLabel?.text = ""

        let writingTask = DispatchWorkItem { [weak self] in
            text.forEach { char in
                DispatchQueue.main.async {
                    self?.introLabel?.text?.append(char)
                }
                Thread.sleep(forTimeInterval: characterDelay/100)
            }
        }

        let queue: DispatchQueue = .init(label: "typespeed", qos: .userInteractive)
        queue.asyncAfter(deadline: .now() + 0.05, execute: writingTask)
    }



    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in:self)
            if let playButton = self.playButton, playButton.contains(location) {
                 let changeScene = SKAction.run {

                    if let scene = GamePlay (fileNamed: "GamePlay"){
                        scene.scaleMode = .aspectFill

                        self.view?.ignoresSiblingOrder = false
                        self.view?.presentScene(scene)
                    }
                }
                let sequence = SKAction.sequence([SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false),SKAction.wait(forDuration: 0.2), changeScene])

                playButton.run(sequence)
            }
        }
    }
}
