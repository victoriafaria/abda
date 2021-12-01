//
//  GamePlay.swift
//  abda
//
//  Created by Victoria Faria on 29/11/21.
//

import SpriteKit

class GamePlay: SKScene {
    // sprites
    var o2: SKSpriteNode?
    var timeLabel: SKLabelNode?
    var scoreLabel: SKLabelNode?
    var emptyTouch: SKSpriteNode?
    var abdazinha: SKSpriteNode?

    //score
    public var score = 0

    //time
    var timer: Timer!
    var timerGame: Timer?
    var timerInt = 60

    override func didMove(to view: SKView) {
        self.o2 = self.childNode(withName: "o2") as? SKSpriteNode

        self.timeLabel = self.childNode(withName: "timeInt") as? SKLabelNode
        self.scoreLabel = self.childNode(withName: "scoreInt") as? SKLabelNode

        self.abdazinha = self.childNode(withName: "abdazinha") as? SKSpriteNode
        let moveAbdaUp = SKAction.move(to: CGPoint(x: -580, y: 650), duration: 4.0)
        let moveAbdaDown = SKAction.move(to: CGPoint(x: -580, y: 750), duration: 4.0)
        let moveSequenceUpDown = SKAction.sequence([moveAbdaUp,moveAbdaDown])
        let abdaMoving = SKAction.repeatForever(moveSequenceUpDown)

        self.abdazinha?.run(abdaMoving)

        speedSpawn()
        setTimer()
    }


    private func setTimer() {
        timerGame = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (theTimer) in

            self.timerInt -= 1

            if self.timerInt == 0 {
                theTimer.invalidate()
                self.gameOver()
            } else {
                self.updateTimeLabel()
            }

            if self.timerInt == 10 {
                let fadeIn = SKAction.fadeIn(withDuration: 0.5)
                let fadeOut = SKAction.fadeOut(withDuration: 0.5)
                let color =  SKAction.colorize(with: .red, colorBlendFactor: 1.0, duration: 0.5)
                let restore = SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.5)

                let colorSequence  = SKAction.sequence([color, SKAction.wait(forDuration: 0.3),  restore])
                let blink = SKAction.sequence([fadeIn,fadeOut])
                let colorGrpup  = SKAction.group([blink, colorSequence])

                let blinkForever = SKAction.repeatForever(colorGrpup)
                self.timeLabel?.run(blinkForever)
            }
        })
    }

    private func speedSpawn() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true, block: { (timer) in
            if self.timerInt < 40 {
                self.spawnO2(speed: 3)
                self.spawnO2(speed: 2)
                self.spawnMeteor(speed: 4)
                self.spawnPlanet(speed: 2)
            } else if self.timerInt < 25 {
                self.spawnO2(speed: 6)
                self.spawnO2(speed: 3)
                self.spawnO2(speed: 5)
                self.spawnPlanet(speed: 3)

                self.spawnMeteor(speed: 6)
            } else {
                self.spawnO2(speed: 3)
            }
        })
    }

    private func spawnO2(speed: Double) {
        // create 02
        let texture = SKTexture(imageNamed: "o2")
        let o2 = SKSpriteNode(texture: texture)
        let randY = 430 + Int(arc4random_uniform(580))

        //random position
        let point = CGPoint(x: 0, y: randY)
        o2.position = point
        let moveLeft = SKAction.moveBy(x: -750, y: 0, duration: speed)
        let remove = SKAction.removeFromParent()
        let actions = SKAction.sequence([moveLeft,remove])

        // add o2
        o2.name = "o2"
        o2.zPosition = 2
        self.addChild(o2)
        o2.run(actions)
    }

    private func spawnPlanet(speed: Double) {
        // create 02
        let texture = SKTexture(imageNamed: "planet")
        let planet = SKSpriteNode(texture: texture)
        let randY = 430 + Int(arc4random_uniform(580))

        //random position
        let point = CGPoint(x: 0, y: randY)
        planet.position = point
        let moveLeft = SKAction.moveBy(x: -750, y: 0, duration: speed)
        let remove = SKAction.removeFromParent()
        let actions = SKAction.sequence([moveLeft,remove])

        // add planet
        planet.name = "planet"
        planet.zPosition = 2
        self.addChild(planet)
        planet.run(actions)
    }

    private func spawnMeteor(speed: Double) {
        // create 02
        let texture = SKTexture(imageNamed: "meteoro")
        let meteor = SKSpriteNode(texture: texture)
        let randY = 430 + Int(arc4random_uniform(580))

        //random position
        let point = CGPoint(x: 0, y: randY)
        meteor.position = point
        let moveLeft = SKAction.moveBy(x: -750, y: 0, duration: speed)
        let remove = SKAction.removeFromParent()
        let actions = SKAction.sequence([moveLeft,remove])

        // add meteoro
        meteor.name = "meteoro"
        meteor.zPosition = 2
        self.addChild(meteor)
        meteor.run(actions)
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(_:positionInScene)
            emptyTouch = touchedNode as? SKSpriteNode


            if emptyTouch?.name == "o2"{
                self.emptyTouch?.run(SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false))
                addScore()
                self.emptyTouch?.removeFromParent()
            } else if emptyTouch?.name == "meteoro" {
                self.emptyTouch?.run(SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false))
                losePoint()
                self.emptyTouch?.removeFromParent()
            } else if emptyTouch?.name == "planet" {
                self.emptyTouch?.run(SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false))
                self.emptyTouch?.removeFromParent()
                gameOver()
            }
        }
    }


    func updateTimeLabel() {
       timeLabel?.text = String(format: "00:%02d", timerInt)
    }

    func addScore() {
        score += 100
        self.scoreLabel?.text = "\(score)"
    }

    func losePoint() {
        score -= 100
        self.scoreLabel?.text = "\(score)"
    }

    func gameOver() {
        if self.timerInt == 0 || emptyTouch?.name == "planet" {
            if let scene = ScoreScene (fileNamed: "ScoreScene"){
                scene.scaleMode = .aspectFill
                scene.score2 = self.score

                self.view?.ignoresSiblingOrder = true
                self.view?.presentScene(scene)

            }
        }
    }
}
