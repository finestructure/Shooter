//
//  Rng.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 13/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import UIKit


class Rng: NSObject {

    class func uniform() -> Double {
        return Double(arc4random()) / Double(UInt32.max);
    }
    
    
    class func uniform(max: Double) -> Double {
        return uniform() * max
    }
    
    
    class func uniformMin(min: Double, max: Double) -> Double {
        return min + uniform(max - min)
    }
    
    class func uniformRange(range: CGVector) -> Double {
        return uniformMin(range.dx, max: range.dy)
    }

}
