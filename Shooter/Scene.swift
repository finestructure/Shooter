//
//  Scene.swift
//  Shooter
//
//  Created by Sven Schmidt on 15/09/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import Foundation
import SpriteKit


let FlameYOffset: CGFloat = 100

class Scene: SKScene, SKPhysicsContactDelegate {
    
    var gameIsRunning = false
    var startTime: NSTimeInterval = 0
    var floor: Floor?
    var flame: Flame?
    var intro: SKLabelNode?
    var time: SKLabelNode?
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1)
        
        // description
        intro = SKLabelNode(fontNamed: "Chalkduster")
        intro?.text = "Touch to start"
        intro?.fontSize = 24
        intro?.position = CGPoint(x: CGRectGetMidX(self.frame), y: self.frame.size.height - 100)
        self.addChild(intro!)
        
        // time
        time = SKLabelNode(fontNamed: "Chalkduster")
        time?.text = ""
        time?.fontSize = 16
        time?.fontColor = SKColor.orangeColor()
        time?.position = CGPoint(x: 20, y: self.frame.size.height - 40)
        time?.horizontalAlignmentMode = .Left
        time?.alpha = 0
        self.addChild(time!)
        
        // floor
        floor = Floor(height: 50, scene: self)
        
        // flame
        flame = Flame(position: CGPoint(x: CGRectGetMidX(self.frame), y: FlameYOffset))
        self.addChild(flame!)
        
        // play no_sound to init audio system (this prevents lag when the game over sound is played at the end
        self.runAction(SKAction.playSoundFileNamed("no_sound.m4a", waitForCompletion: false))
        
        self.physicsWorld.gravity = CGVector(0, 0)
        self.physicsWorld.contactDelegate = self
    }

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func isGameOver() -> Bool {
        return self.floor?.maxHeight >= self.flame?.bottomEdgeY
    }
    
    
    func startGame() {
        // fade out intro
        let fall = SKAction.moveByX(0, y: -self.frame.size.height, duration: 2)
        let fade = SKAction.fadeOutWithDuration(1)
        let remove = SKAction.removeFromParent()
        let fadeAndRemove = SKAction.sequence([fade, remove])
        let group = SKAction.group([fall, fadeAndRemove])
        self.intro?.runAction(group)
        // fade in time
        time?.runAction(SKAction.fadeInWithDuration(1.5))
        // start snow
        SnowMachine.startInScene(self)
        self.gameIsRunning = true
    }
    
    
    func endGame(survivalTime: CFTimeInterval) {
        gameIsRunning = false
        
        NSLog("GAME OVER!")
        
        SnowMachine.stop()
        
        let bubbleUp = SKAction.sequence([
            SKAction.scaleTo(1.4, duration: 0.3),
            SKAction.scaleTo(0.8, duration: 0.1),
            SKAction.scaleTo(1.2, duration: 0.1),
            SKAction.scaleTo(0.9, duration: 0.1),
            SKAction.scaleTo(1.0, duration: 0.1),
            ])
        
        // present game over label
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "GAME OVER!"
        label.fontColor = SKColor.orangeColor()
        label.fontSize = 30
        label.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        label.setScale(0)
        label.runAction(bubbleUp)
        self.addChild(label)
        
        // score label
        let score1 = SKLabelNode(fontNamed: "Chalkduster")
        score1.fontSize = 18
        score1.text = "You survived for"
        score1.position = CGPoint(
            x: CGRectGetMidX(self.frame),
            y: CGRectGetMidY(self.frame) - 40
        )
        score1.setScale(0)
        self.addChild(score1)

        let score2 = SKLabelNode(fontNamed: "Chalkduster")
        score2.fontSize = 18
        score2.text = NSString(format: "%.1f seconds", survivalTime)
        score2.position = CGPoint(
            x: CGRectGetMidX(self.frame),
            y: CGRectGetMidY(self.frame) - 70
        )
        score2.setScale(0)
        self.addChild(score2)
        
        score1.runAction(SKAction.sequence([SKAction.waitForDuration(1), bubbleUp]))
        score2.runAction(SKAction.sequence([SKAction.waitForDuration(2), bubbleUp]))
        
        // fade out time
        self.time?.runAction(SKAction.fadeOutWithDuration(0.5))
        
        // play game over sound
        self.runAction(SKAction.playSoundFileNamed("game_over.m4a", waitForCompletion: false))
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        // BLOG
        if let nodeA = contact.bodyA.node as? CollisionHandling {
            nodeA.collide(contact.bodyB)
        }
        if let nodeB = contact.bodyB.node as? CollisionHandling {
            nodeB.collide(contact.bodyA)
        }
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if !self.gameIsRunning && !self.isGameOver() {
            self.startGame()
        }
    }
    
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let loc = touch.locationInNode(self)
            let newLoc = CGPoint(x: loc.x, y: self.flame?.position.y ?? 0)
            self.flame?.position = newLoc
        }
    }
    
    
    override func update(currentTime: NSTimeInterval) {
        if self.gameIsRunning {
            // FIXME: in the absence of static vars we use this semi-hack
            // (the struct trick crashes the compliler in 6.1b1)
            if self.startTime <= 0 {
                self.startTime = currentTime
            }
            var survivalTime = currentTime  - self.startTime
            self.time?.text = NSString(format: "%.1f", survivalTime)
            if self.isGameOver() {
                self.endGame(survivalTime)
            }
        }
    }
}

