//
//  winScreen.swift
//  ZombieConga
//
//  Created by Gurjeet kaur on 2019-10-15.
//  Copyright © 2019 The Lambton. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

class winScreen: SKScene {
    override init(size: CGSize) {
           super.init(size: size)
        }
    
        required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    override func didMove(to view: SKView) {
    // Set the background color of the app
             
     self.backgroundColor = SKColor.black;
     let bg = SKSpriteNode(imageNamed: "YouWin")
     bg.position = CGPoint(x: size.width/2, y: size.height/2)
     bg.zPosition = -1
     addChild(bg)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            // when person touches screen, show the main screen
            let mainGameScreen = GameScene(size:self.size)
            self.view?.presentScene(mainGameScreen)
        }
    
    
}
