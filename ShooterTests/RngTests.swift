//
//  RngTest.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 12/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import XCTest

let NumberOfIterations = 10000
let ThreeSigma = 0.03

class RngTest: XCTestCase {
    
    func testUniform() {
        var sum: Double = 0
        var min = Double(Int.max)
        var max: Double = 0
        for var i = 0; i < NumberOfIterations; ++i {
            var value = Rng.uniform()
            min = (value < min) ? value : min
            max = (value > max) ? value : max
            sum += value
        }
        let avg = sum/Double(NumberOfIterations)
        XCTAssertEqualWithAccuracy(avg, 0.5, ThreeSigma, "")
        XCTAssertTrue(min >= 0, "min was: \(min)")
        XCTAssertTrue(max < 1, "max was: \(max)")
    }
    
}
