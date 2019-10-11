//
//  GameScene.swift
//  ZombieConga
//
//  Created by Gurjeet kaur on 2019-10-10.
//  Copyright © 2019 The Lambton. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
   // Set the background color of the app
            self.backgroundColor = SKColor.black;
            
           let bg = SKSpriteNode(imageNamed: "background1")
                  bg.position = CGPoint(x: size.width/2, y: size.height/2)
                  bg.zPosition = -1
                  addChild(bg)
            
            
            let zombie = SKSpriteNode(imageNamed: "zombie2")
                    zombie.position = CGPoint(x:200, y:200)
                    addChild(zombie)
        
    }
 
        }
    
    
    
   
