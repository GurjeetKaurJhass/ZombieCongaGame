//
//  loseScreen.swift
//  ZombieConga
//
//  Created by Gurjeet kaur on 2019-10-15.
//  Copyright © 2019 The Lambton. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

class loseScreen: SKScene {
    override init(size: CGSize) {
           super.init(size: size)
        }
    
        required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    override func didMove(to view: SKView) {
    // Set the background color of the app
             
     self.backgroundColor = SKColor.black;
     let bg = SKSpriteNode(imageNamed: "YouLose")
     bg.position = CGPoint(x: size.width/2, y: size.height/2)
     bg.zPosition = -1
     addChild(bg)
        
    
    }
}
