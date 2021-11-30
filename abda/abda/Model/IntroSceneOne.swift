//
//  IntroSceneOne.swift
//  abda
//
//  Created by Victoria Faria on 28/11/21.
//

import Foundation
import SpriteKit

class IntroSceneOne: SKScene {

    private var background: SKSpriteNode?
    private var introLabel: SKLabelNode?
    private var nextButton: SKSpriteNode?

    override func didMove(to view: SKView) {

        // show the typing
        // ps: Just for less texts
        self.introLabel = self.childNode(withName: "introLabel") as? SKLabelNode
        setTyping(text: "........ ")

        // show nextButton
        self.nextButton = self.childNode(withName: "nextButton") as? SKSpriteNode


        //show background
        self.background = self.childNode(withName: "background") as? SKSpriteNode
        let moveAngelUp = SKAction.move(to: CGPoint(x: 100, y: 0), duration: 3.0)
        let moveAngelDown = SKAction.move(to: CGPoint(x: -100, y: 0), duration: 3.0)

        let moveSequenceUpDown = SKAction.sequence([moveAngelUp,moveAngelDown])
        let bgMoving = SKAction.repeatForever(moveSequenceUpDown)

        self.background?.run(bgMoving)
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
            if let nextButton = self.nextButton, nextButton.contains(location) {
                 let changeScene = SKAction.run {

                    if let scene = IntroSceneTwo (fileNamed: "IntroSceneTwo"){
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
