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

    //score
    public var score = 0


    //time
    var timer: Timer!
    var timerGame: Timer?
    var timerInt = 60



    override func didMove(to view: SKView) {

        self.o2 = self.childNode(withName: "o2") as? SKSpriteNode



        timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true, block: { (timer) in
            if self.timerInt < 40 {
                self.spawnThings(speed: 3)
                self.spawnThings(speed: 2)
            } else if self.timerInt < 20 {
                self.spawnThings(speed: 6)
                self.spawnThings(speed: 3)
                self.spawnThings(speed: 5)
            } else {
                self.spawnThings(speed: 3)
            }
        })


    }


    func spawnThings(speed: Double) {

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


}
