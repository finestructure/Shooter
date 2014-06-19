//
//  SKEmitterNode+Util.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 13/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import SpriteKit

extension SKEmitterNode {

//    class func emitterNodeWithParticleFileNamed(name: String) -> SKEmitterNode {
//        let path = NSBundle.mainBundle().pathForResource(name.stringByDeletingPathExtension, ofType: "sks")
//        return NSKeyedUnarchiver.unarchiveObjectWithFile(path) as SKEmitterNode
//    }

    convenience init(particleFileName: String) {
        let path = NSBundle.mainBundle().pathForResource(particleFileName.stringByDeletingPathExtension, ofType: "sks")
        let data = NSData(contentsOfFile: path)
        let coder = NSKeyedUnarchiver(forReadingWithData: data)
        self.init(coder: coder)
    }
    
}