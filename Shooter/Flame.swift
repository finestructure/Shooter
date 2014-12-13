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
        self.init()
        
        self.particleTexture = SKTexture(imageNamed: "spark.png")
        self.particleBirthRate = 500
        self.particleLifetime = 0.7
        self.particlePositionRange = CGVectorMake(10, 3)
        self.emissionAngle = CGFloat(M_PI_2)
        self.emissionAngleRange = 5 * CGFloat(M_PI)/180
        self.particleSpeed = 80
        self.particleSpeedRange = 20
        self.particleAlpha = 0.8
        self.particleColorAlphaRange = 0.2
        self.particleColorAlphaSpeed = -0.4
        self.particleScale = 0.2
        self.particleScaleSpeed = -0.1
        self.particleColorBlendFactor = 1
        self.particleColorBlendFactorSpeed = 1
        self.particleColor = UIColor(red: 78.0/255, green: 33.0/255, blue: 6.0/255, alpha: 1)
        self.particleBlendMode = .Add
        
        self.position = position
        self.name = "Flame"
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 24, height: 110))
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = ObjectCategory.Flame.toBitMask()
    }
    
    func collide(body: SKPhysicsBody) {
        if let flake = body.node as? Snowflake {
            Collider.collide(flake: flake, flame: self)
        }
    }
}
