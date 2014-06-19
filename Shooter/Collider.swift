//
//  File.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 16/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import Foundation


class Collider {
    class func collide(flake: Snowflake, flame: Flame) {
        flake.evaporate()
    }

    class func collide(flake: Snowflake, floorSegment: FloorSegment) {
        flake.hasLanded()
        floorSegment.absorbSnowflake(flake)
    }
}