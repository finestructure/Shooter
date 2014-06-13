//
//  SKEmitterNode+Util.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 13/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import SpriteKit

extension SKEmitterNode {

    class func emitterNodeWithParticleFileNamed(name: String) -> SKEmitterNode {
        let path = NSBundle.mainBundle().pathForResource(name.stringByDeletingPathExtension, ofType: "sks")
        return NSKeyedUnarchiver.unarchiveObjectWithFile(path) as SKEmitterNode
    }

}