//
//  Snowflake.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 18/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import Foundation
import SpriteKit


class Snowflake: SKSpriteNode, CollisionHandling {
    init(scale: CGFloat) {
        let texture = SKTexture(imageNamed: "spark.png")
        super.init(texture: texture, color: nil, size: texture.size())
        self.size = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        self.name = "Snowflake"
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2 * 0.3)
        self.physicsBody?.categoryBitMask = ObjectCategory.Snow.toBitMask()
        self.physicsBody?.collisionBitMask = ObjectCategory.Flame.toBitMask() | ObjectCategory.Floor.toBitMask()
        self.physicsBody?.contactTestBitMask = ObjectCategory.Flame.toBitMask() | ObjectCategory.Floor.toBitMask()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func hasLanded() {
        removeAllActions()
        self.physicsBody = nil
        let fade = SKAction.fadeOutWithDuration(12)
        let remove = SKAction.removeFromParent()
        runAction(SKAction.sequence([fade, remove]))
    }
    
    func evaporate() {
        removeAllActions()
        var steam = SKEmitterNode(fileNamed: "steam")
        let remove = SKAction.removeFromParent()
        let puff = SKAction.runBlock {
            steam.position = self.position
            self.scene?.addChild(steam)
            let wait = SKAction.waitForDuration(1)
            steam.runAction(SKAction.sequence([wait, remove]))
        }
        runAction(SKAction.sequence([puff, remove]))
    }
    
    func collide(body: SKPhysicsBody) {
        if let floor = body.node as? FloorSegment {
            Collider.collide(flake: self, floorSegment: floor)
        }
        if let flame = body.node as? Flame {
            Collider.collide(flake: self, flame: flame)
        }
    }
}