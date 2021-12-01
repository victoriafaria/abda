//
//  GameScene.swift
//  abda
//
//  Created by Victoria Faria on 28/11/21.
//

import SpriteKit
import GameplayKit
import AVFoundation

var soundNode = AVAudioPlayer()

func stopSound() {
    soundNode.stop()
}

class GameScene: SKScene {

    private var background: SKSpriteNode?
    private var startButton: SKSpriteNode?
    private var abda: SKSpriteNode?
    
    override func didMove(to view: SKView) {

        //show start
        self.startButton = self.childNode(withName: "startButton") as? SKSpriteNode

        //show background
        self.background = self.childNode(withName: "background") as? SKSpriteNode
        let moveAngelUp = SKAction.move(to: CGPoint(x: 100, y: 0), duration: 3.0)
        let moveAngelDown = SKAction.move(to: CGPoint(x: -100, y: 0), duration: 3.0)
        let moveSequenceUpDown = SKAction.sequence([moveAngelUp,moveAngelDown])
        let bgMoving = SKAction.repeatForever(moveSequenceUpDown)
        self.background?.run(bgMoving)


        //show abda
        self.abda = self.childNode(withName: "abda") as? SKSpriteNode
        let moveAbda = SKAction.move(to: CGPoint(x: 0, y: 190), duration: 3.0)
        let abdaLeft = SKAction.rotate(byAngle: -0.2, duration: 1.0)
        let abdaRight = SKAction.rotate(byAngle: 0.2, duration: 1.0)

        let moveSequence = SKAction.sequence([abdaLeft,abdaRight])

        let abdaBounce = SKAction.repeatForever(moveSequence)

        self.abda?.run(moveAbda)
        self.abda?.run(abdaBounce)

        playSound()
    }//end didMove


    func playSound() {
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "bensound-adventure-2-2", ofType: "mp3")!)
        soundNode = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        soundNode.prepareToPlay()
        soundNode.numberOfLoops = -1
        soundNode.play()
    }

//    func backgroundSound() {
//        let sound = SKAction.playSoundFileNamed("bensound-adventure-2-2.mp3", waitForCompletion: true)
//        self.addChild(soundNode)
//        soundNode.run(SKAction.repeatForever(sound))
//    }

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
