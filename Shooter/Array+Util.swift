//
//  Array+Util.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 19/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import Foundation

extension Array {
    var last: T? {
    if self.count > 0 {
        return self[self.endIndex - 1]
    } else {
        return nil
        }
    }
}
