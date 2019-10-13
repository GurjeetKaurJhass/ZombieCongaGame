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
    var makeZombieMoveRight:Bool=true
    var makeZombieMoveLeft:Bool=false
    
        var timeOfLastUpdate:TimeInterval = 0
        var dt:TimeInterval = 0
    
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
        
        
        
        
        let move1 = SKAction.move(to: CGPoint(x: size.width/2 , y: 400),
                                                duration: 2)
        let move2 = SKAction.move(to:CGPoint(x:100, y:size.height/2), duration:2)
                    let move3 = SKAction.move(to:CGPoint(x:size.width/2, y:400), duration:2)
                      let move4 = SKAction.move(to:CGPoint(x:size.width - 100, y:size.height / 2), duration:2)
                      
                      let grandmaAnimation = SKAction.sequence(
                          [move1,move2, move3, move4])
                let grandmaForeverAnimation = SKAction.repeatForever(grandmaAnimation)
               self.gramma.run(grandmaForeverAnimation)
        
     
    }
    
    
    override func update(_ currentTime: TimeInterval) {
          
        

        // DEBUG:  Show the time between updats
              

//       let screenRightSide = size.width
//      var zombieX =  self.zombie.position.x
//        if(self.makeZombieMoveLeft==true)
//        {
//            zombieX =  self.zombie.position.x-10
//
//            if(zombieX<=0)
//            {
//
//                self.makeZombieMoveRight=true
//                self.makeZombieMoveLeft=false
//            }
//        }
//
//        if(self.makeZombieMoveRight==true)
//        {
//          zombieX =  self.zombie.position.x+10
//
//            if(zombieX>=screenRightSide)
//            {
//                self.makeZombieMoveLeft=true
//                self.makeZombieMoveRight=false
//            }
//        }
//
//        self.zombie.position = CGPoint(x: zombieX, y: self.zombie.position.y)
//    }
//
       if (timeOfLastUpdate > 0) {
                   // currentTIme is a parameter in the update() function
                    dt = currentTime - timeOfLastUpdate;
               } else {
                    dt = 0
                 }
       
   timeOfLastUpdate = currentTime
       print("\(dt*1000) ms since last update")
        // first version of upgraded movement
               let v = CGPoint(x:self.zombieMovementPerSecond, y:0)
               self.move(sprite: self.zombie, velocity: v)
        
        
                // second version of upgraded movement
                self.move(sprite: self.zombie, velocity: self.velocity)
        
                self.checkGameBoundaries()
        
        
           // calculate offset between the zombie and the touch
               //self.moveZombieToward(location: touchLocation)
            }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
       {
           let touch = touches.first
           if(touch == nil)
           {
               return
           }
           let touchLocation=touch!.location(in: self)
           print("user tapped at\(touchLocation.x.rounded()),\(touchLocation.y.rounded())")
           self.moveZombieToward(location:touchLocation)
       }
        
        
          // MARK:  Handle zombie movement
            func move(sprite:SKSpriteNode, velocity:CGPoint) {
              // v = f(direction,distance)
        
                let amountToMove = CGPoint(x: velocity.x * CGFloat(dt),
                                           y:  velocity.y * CGFloat(dt) )
        
               print("Amount to move: \(amountToMove)")
        
               // update the sprite's position
               let newX = sprite.position.x + amountToMove.x
               let newY = sprite.position.y + amountToMove.y
               sprite.position = CGPoint(x:newX, y:newY)
        
        
            }
        
            func moveZombieToward(location:CGPoint) {
                let offset = CGPoint(x:location.x - zombie.position.x,
                                    y:location.y - zombie.position.y)
        
               let aSquared = offset.x * offset.x
               let bSquared = offset.y * offset.y
        
               let hypotenuese:Double = sqrt(Double(aSquared + bSquared))
        
                let direction = CGPoint(x: offset.x / CGFloat(hypotenuese),
                                        y: offset.y / CGFloat(hypotenuese))
        
                self.velocity = CGPoint(x: direction.x * zombieMovementPerSecond,
                                        y: direction.y * zombieMovementPerSecond)
        
        
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
    
    
    
   
