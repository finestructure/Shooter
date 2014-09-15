//
//  Constants.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 16/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import UIKit

//BLOG
//FIXME: - swift enums cannot be used in objc
@objc class ObjectCategory: NSObject {
    class func Floor() -> UInt32 {
        return (0x1 << 0)
    }
    class func Flame() -> UInt32 {
        return (0x1 << 1)
    }
    class func Snow() -> UInt32 {
        return (0x1 << 2)
    }
}

//enum ObjectCategory: Int {
//    case Floor = 0b0001
//    case Flame = 0b0010
//    case Snow  = 0b0100
//}