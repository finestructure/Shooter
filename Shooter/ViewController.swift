//
//  ViewController.swift
//  Shooter
//
//  Created by Sven Schmidt on 15/09/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let skView = self.view as? SKView {
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            let scene = Scene(size: skView.bounds.size)
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func shouldAutorotate() -> Bool {
        return true
    }
    
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
