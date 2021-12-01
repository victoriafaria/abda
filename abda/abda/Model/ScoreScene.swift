//
//  ScoreScene.swift
//  abda
//
//  Created by Victoria Faria on 30/11/21.
//

import SpriteKit

class ScoreScene: SKScene {

    var restartButton: SKSpriteNode?
    var storeButton: SKSpriteNode?
    var background: SKSpriteNode?

    var scoreLabel: SKLabelNode?
    var score2:Int = 0

    var bestScoreLabel: SKLabelNode?
    var bestScore:  Int = 0

    override func didMove(to view: SKView) {

        self.scoreLabel = self.childNode(withName: "scoreIntLabel") as? SKLabelNode
        self.bestScoreLabel = self.childNode(withName: "highScore") as? SKLabelNode


        //show background
        self.background = self.childNode(withName: "background") as? SKSpriteNode
        let moveAngelUp = SKAction.move(to: CGPoint(x: 100, y: 0), duration: 3.0)
        let moveAngelDown = SKAction.move(to: CGPoint(x: -100, y: 0), duration: 3.0)

        let moveSequenceUpDown = SKAction.sequence([moveAngelUp,moveAngelDown])
        let bgMoving = SKAction.repeatForever(moveSequenceUpDown)

        self.background?.run(bgMoving)


        // Comparacão da ultima pontuação com a melhor pontuação
        if score2 > Int(Persistence.highScore) {
            Persistence.highScore = Double(score2)
        }

        self.scoreLabel?.text = "\(score2)"
        self.bestScoreLabel?.text = "\(Int(Persistence.highScore))"


        //show store
        self.storeButton = self.childNode(withName: "storeButton") as? SKSpriteNode


      //show button restart
        self.restartButton = self.childNode(withName: "restartButton") as? SKSpriteNode

    }


    // segue scene

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let location = touch.location(in:self)
            if let storeButton = self.storeButton,storeButton.contains(location) {
                let changeScene = SKAction.run {

                    if let scene = GameScene (fileNamed: "GameScene"){
                        scene.scaleMode = .aspectFill
                        self.view?.ignoresSiblingOrder = false
                        self.view?.presentScene(scene)
                    }
                }

                let sequence = SKAction.sequence([SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false),SKAction.wait(forDuration: 0.7), changeScene])
                stopSound()
                storeButton.run(sequence)
            }

            else if let restartButton = self.restartButton,restartButton.contains(location) {
                let changeScene = SKAction.run {
                    if let scene = GamePlay (fileNamed: "GamePlay"){
                        scene.scaleMode = .aspectFill
                        self.view?.ignoresSiblingOrder = false
                        self.view?.presentScene(scene)

                    }
                }

                let sequence = SKAction.sequence([SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false),SKAction.wait(forDuration: 0.7), changeScene])
                restartButton.run(sequence)

            }

        }

    }

}
