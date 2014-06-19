//
//  Flame.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 18/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import Foundation
import SpriteKit


class Flame: SKEmitterNode, CollisionHandling {
    var bottomEdgeY: CGFloat {
    get {
        return self.frame.origin.y + 40
    }
    }
    
    convenience init(position: CGPoint) {
        NSKeyedUnarchiver.setClass(Flame.classForCoder(), forClassName: "SKEmitterNode")
        self.init(particleFileName:"flame")
        
        self.position = position
        self.name = "Flame"
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 24, height: 110))
        self.physicsBody.dynamic = false
        self.physicsBody.categoryBitMask = ObjectCategory.Flame()
    }
    
    func collide(body: SKPhysicsBody) {
        Collider.collide(body.node as Snowflake, flame: self)
    }
}
