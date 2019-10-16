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

    var zombie:SKSpriteNode = SKSpriteNode(imageNamed:"zombie1")
    var gramma:SKSpriteNode = SKSpriteNode(imageNamed:"enemy")
    var cat:SKSpriteNode = SKSpriteNode(imageNamed: "cat")
    var makeZombieMoveRight:Bool=true
    var makeZombieMoveLeft:Bool=false
    var livesLabel:SKLabelNode!
    
        var timeOfLastUpdate:TimeInterval = 0
        var dt:TimeInterval = 0
        var lives = 100
        // variables to deal with movement
        let zombieMovementPerSecond: CGFloat = 480.0
        var velocity = CGPoint.zero // this is a built in Swift constant. It equals (0,0)
    
    
    override func didMove(to view: SKView) {
   // Set the background color of the app
            
    self.backgroundColor = SKColor.black;
    let bg = SKSpriteNode(imageNamed: "background1")
    bg.position = CGPoint(x: size.width/2, y: size.height/2)
    bg.zPosition = -1
    addChild(bg)
       
    zombie = SKSpriteNode(imageNamed: "zombie1")
    zombie.position = CGPoint(x:400, y:400)
    addChild(zombie)
        
    gramma=SKSpriteNode(imageNamed: "enemy")
    self.gramma.position = CGPoint(x:size.width-100, y:size.height/2)
    addChild(self.gramma)
        
        
        
        
         // Add life label
            self.livesLabel = SKLabelNode(text: "Lives Remaining: \(lives)")
            self.livesLabel.position = CGPoint(x:400, y:800)
            self.livesLabel.fontColor = UIColor.yellow
            self.livesLabel.fontSize = 65
            self.livesLabel.fontName = "Avenir"
            addChild(self.livesLabel)
        
        
        
        
    let move1 = SKAction.move(to: CGPoint(x: size.width/2 , y: 400),
                                                duration: 2)
    let move2 = SKAction.move(to:CGPoint(x:100, y:size.height/2), duration:2)
    let move3 = SKAction.move(to:CGPoint(x:size.width/2, y:400), duration:2)
    let move4 = SKAction.move(to:CGPoint(x:size.width - 100, y:size.height / 2), duration:2)
    let grandmaAnimation = SKAction.sequence([move1,move2, move3, move4])
    let grandmaForeverAnimation = SKAction.repeatForever(grandmaAnimation)
               self.gramma.run(grandmaForeverAnimation)
//        let zombieAnimation = SKAction.sequence(
//                   [move3, move4]
//        )
//            self.zombie.run(zombieAnimation)
        
    }
    var numLoops = 0
    override func update(_ currentTime: TimeInterval) {
          
        
       if (timeOfLastUpdate > 0) {
                   // currentTIme is a parameter in the update() function
                    dt = currentTime - timeOfLastUpdate;
               } else {
                    dt = 0
                 }
       
   timeOfLastUpdate = currentTime
       
               //let v = CGPoint(x:self.zombieMovementPerSecond, y:0)
        
        
        numLoops = numLoops + 1
                if (numLoops % 120 == 0) {
                    // make a cat
                   self.spawnCat()
        
                }
         
        self.moveZombieToward(mouseXPosition: self.mouseX, mouseYPostion: self.mouseY)
        // second version of upgraded movement
                
                self.checkGameBoundaries()
    
        
        
        if (self.zombie.frame.intersects(self.gramma.frame) == true) {
                    print("\(currentTime): COLLISON!")
            
            self.lives=self.lives-1
            self.livesLabel.text = "Lives Remaining \(lives)"
                }
        
        
           // calculate offset between the zombie and the touch
               //self.moveZombieToward(location: touchLocation)
            }
    var cats:[SKSpriteNode] = []
         
        func spawnCat() {
            // Add a cat to a static location
           let cat = SKSpriteNode(imageNamed: "cat")
    
            // generate a random x position
            let randomXPos = CGFloat.random(in: 0 ... size.width)
            let randomYPos = CGFloat.random(in: 0 ... size.height)
            cat.position = CGPoint(x:randomXPos, y:randomYPos)
    
            // add the cat to the screen
            addChild(cat)
    
           // add the cat to the array
            self.cats.append(cat)
    
        }
    
    var mouseX:CGFloat = 0
    var mouseY:CGFloat = 0
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
       {
            let locationTouched = touches.first
                   if (locationTouched == nil) {
                       // an error occured
                       return
                   }
                   
                   let mousePosition = locationTouched!.location(in:self)
                   
                   print("mouseX = \(mousePosition.x)")
                   print("mouseY = \(mousePosition.y)")
                   print("-------")
                   
                   
                   // 2. @TODO: set the global mosueX and mouseY variables to the mouse (x,y)
                   self.mouseX = mousePosition.x
                   self.mouseY = mousePosition.y
       }
        
        
            func moveZombieToward(mouseXPosition:CGFloat, mouseYPostion:CGFloat) {
                       // 1. calculate disatnce between mouse and zombie
                        let a = (self.mouseX - self.zombie.position.x);
                        let b = (self.mouseY - self.zombie.position.y);
                        let distance = sqrt((a * a) + (b * b))
                       // 2. calculate the "rate" to move
                        let xn = (a / distance)
                        let yn = (b / distance)
                
                        // 3. move the bullet
                        self.zombie.position.x = self.zombie.position.x + (xn * 10);
                        self.zombie.position.y = self.zombie.position.y + (yn * 10);
        
            }
        
           func checkGameBoundaries() {
               //    (topLeft) .-------------. (topRight)
                //              |             |
                //              |             |
              // (bottomLeft) .-------------. (bottomRight)
        
                let bottomLeft = CGPoint.zero
                let topRight = CGPoint(x:size.width, y:size.height)
        
                if (zombie.position.x <= bottomLeft.x) {
                  self.zombie.position.x = bottomLeft.x
                  self.velocity.x = self.velocity.x * -1
               }
        
               if (zombie.position.x >= topRight.x) {
                   self.zombie.position.x = topRight.x
                   self.velocity.x = self.velocity.x * -1
                }
        
                if (zombie.position.y <= bottomLeft.y) {
                   self.zombie.position.y = bottomLeft.y
                   self.velocity.y = self.velocity.y * -1
               }
        
                if (zombie.position.y >= topRight.y) {
                    self.zombie.position.y = topRight.y
                    self.velocity.y = self.velocity.y * -1
                }
        
             }
    
        
}
    
    
    
   
