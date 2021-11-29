//
//  IntroSceneOne.swift
//  abda
//
//  Created by Victoria Faria on 28/11/21.
//

import Foundation
import SpriteKit

class IntroSceneOne: SKScene {

    private var introLabel: SKLabelNode?

    override func didMove(to view: SKView) {

        // set the typing
        // ps: Just for less texts
        self.introLabel = self.childNode(withName: "introLabel") as? SKLabelNode
        setTyping(text: "E assim começa nossa viagem...")

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
}
