//
//  Constants.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 16/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import UIKit


enum ObjectCategory: UInt32 {
    case Floor = 0
    case Flame
    case Snow
    func toBitMask() -> UInt32 {
        return (0x1 << self.rawValue)
    }
}
