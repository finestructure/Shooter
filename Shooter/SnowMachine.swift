//
//  SnowMachine.swift
//  Shooter
//
//  Created by Sven Schmidt on 15/09/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import Foundation
import SpriteKit


let InitialFlakesPerSecond: CGFloat = 5
let IncreasePerSecond: CGFloat = 4
let ChildCountThrottleLimit = 500

//FIXME: do we need to inherit from NSObject?
class SnowMachine: NSObject {
    
    var scene: SKScene?
    var timer: NSTimer?
    
    
    class var sharedInstance: SnowMachine {
        // BLOG
        struct Singleton {
            static let instance = SnowMachine()
        }
        return Singleton.instance
    }
    
    
    class func startInScene(scene: SKScene) {
        sharedInstance.scene = scene
        sharedInstance.start()
    }


    class func stop() {
        sharedInstance.stop()
    }
    

    private func start() {
        // BLOG
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "snow", userInfo: nil, repeats: true)
    }
    
    
    private func stop() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    
    // BLOG: can't use selector with private func
    func snow() {
        // BLOG
        struct Static {
            static var flakesPerSecond = InitialFlakesPerSecond
        }
        let delayInSeconds = 1/Static.flakesPerSecond
        
        NSLog("### flakesPerSecond: %.0f", Double(Static.flakesPerSecond));
        NSLog("### node count: %lu", self.scene?.children.count ?? 0);

        for i in 0..<Int(Static.flakesPerSecond) {
            let delta = Int64(CGFloat(i) * delayInSeconds * CGFloat(NSEC_PER_SEC))
            let popTime = dispatch_time(DISPATCH_TIME_NOW, delta)
            dispatch_after(popTime, dispatch_get_main_queue()) {
                if self.scene?.children.count < ChildCountThrottleLimit {
                    if let scene = self.scene {
                        let n = SnowMachine.createSnowflakeInScene(scene)
                        scene.addChild(n)
                    }
                } else {
                    Static.flakesPerSecond -= 1
                }
            }
        }
        
        if self.scene?.children.count < ChildCountThrottleLimit {
            Static.flakesPerSecond += IncreasePerSecond
        }
    }
    
    
    private class func createSnowflakeInScene(scene: SKScene) -> Snowflake {
        let timeRange = CGVector(dx: 2, dy: 4)
        let scaleRange = CGVector(dx: 0.15, dy: 0.4)
        let xRange = CGVector(dx: 0, dy: scene.size.width)
        let openingAngle = 12 * M_PI/180
        let angleRange = CGVector(dx: -openingAngle, dy: openingAngle)
        
        let time = Rng.uniformRange(timeRange)
        let scale = CGFloat(Rng.uniformRange(scaleRange))
        let startX = CGFloat(Rng.uniformRange(xRange))
        let angle = CGFloat(Rng.uniformRange(angleRange))
        
        let start = CGPoint(x: startX, y: scene.size.height + 10.0)
        let x = scene.size.height * tan(angle) + start.x
        let end = CGPoint(x: x, y: 0)
        
        let flake = Snowflake(scale: scale)
        flake.position = start
        let move = SKAction.moveTo(end, duration: time)
        let remove = SKAction.removeFromParent()
        flake.runAction(SKAction.sequence([move, remove]))
        
        return flake
    }
}