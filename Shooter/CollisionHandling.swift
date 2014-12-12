//
//  CollisionHandling.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 16/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import SpriteKit

@objc protocol CollisionHandling {
    func collide(body: SKPhysicsBody)
}