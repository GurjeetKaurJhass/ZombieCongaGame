//
//  GameViewController.swift
//  ZombieConga
//
//  Created by Gurjeet kaur on 2019-10-10.
//  Copyright © 2019 The Lambton. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       let scene = GameScene(size:CGSize(width:1536, height:2048))
        let skView = self.view as! SKView
        skView.showsFPS = true
       
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }

   
}
