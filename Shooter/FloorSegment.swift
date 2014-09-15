//
//  FloorSegment.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 18/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import Foundation
import SpriteKit


let GrowthBase: CGFloat = 0.5
let GrowthSizeFraction: CGFloat = 0.025
let GrowthSpeed: Int = 6
let DampeningFactor: CGFloat = 0.8


class FloorSegment: SKNode, CollisionHandling {
    var next: FloorSegment? = nil
    var previous: FloorSegment? = nil
    var visibleHeight: CGFloat {
    get {
        // This is a bit of a hack - we use the fact that the position is half of the height, because
        // that's how the segment is set up above. (We don't have access to the actual height.)
        return self.position.y * 2;
    }
    }
    
    init(rect: CGRect) {
        super.init()
        self.position = CGPoint(x: CGRectGetMidX(rect), y: CGRectGetMidY(rect))
        self.name = "FloorSegment"
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: rect.size)
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = ObjectCategory.Floor()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func collide(body: SKPhysicsBody) {
        if let flake = body.node as? Snowflake {
            Collider.collide(flake: flake, floorSegment: self)
        }
    }
    
    func growBy(growth: CGFloat) {
        if !hasActions() {
            let duration = 0.1;
            let move = SKAction.moveByX(0, y: growth, duration: duration)
            runAction(move)
        }
    }

    func absorbSnowflake(flake: Snowflake) {
        var growth = GrowthBase + flake.size.height * GrowthSizeFraction;
        growBy(growth)
    
        // spread the growth to adjacent segments to get a smoother distribution
        var prev = self.previous;
        var next = self.next;
        for i in 0..<GrowthSpeed {
            growth = growth * DampeningFactor;
            prev?.growBy(growth)
            next?.growBy(growth)
            prev = prev?.previous
            next = next?.next
        }
    }
}
