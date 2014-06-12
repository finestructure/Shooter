//
//  RngTest.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 12/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import XCTest

let NumberOfIterations = 100000
let ThreeSigma = 0.03

class RngTest: XCTestCase {
    
    func test_uniform_1() {
        var sum = 0.0
        var min = Double(Int.max)
        var max = 0.0
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
    
    func test_uniform_2() {
        var sum = 0.0
        var min = Double(Int.max)
        var max = 0.0
        for var i = 0; i < NumberOfIterations; ++i {
            var value = Rng.uniform(5)
            min = (value < min) ? value : min
            max = (value > max) ? value : max
            sum += value
        }
        let avg = sum/Double(NumberOfIterations)
        XCTAssertEqualWithAccuracy(avg, 2.5, ThreeSigma, "");
        XCTAssertTrue(min >= 0, "min was: \(min)")
        XCTAssertTrue(max < 5, "max was: \(max)")
    }
    
    func test_uniform_min_max_1() {
        var sum = 0.0
        var min = Double(Int.max)
        var max = 0.0
        for var i = 0; i < NumberOfIterations; ++i {
            var value = Rng.uniformMin(2, max: 6)
            min = (value < min) ? value : min
            max = (value > max) ? value : max
            sum += value
        }
        let avg = sum/Double(NumberOfIterations)
        XCTAssertEqualWithAccuracy(avg, 4, ThreeSigma, "");
        XCTAssertTrue(min >= 2, "min was: \(min)")
        XCTAssertTrue(max < 6, "max was: \(max)")
    }
    
    func test_uniform_min_max_2() {
        var sum = 0.0
        var min = Double(Int.max)
        var max = 0.0
        for var i = 0; i < NumberOfIterations; ++i {
            var value = Rng.uniformMin(-1, max: 5)
            min = (value < min) ? value : min
            max = (value > max) ? value : max
            sum += value
        }
        let avg = sum/Double(NumberOfIterations)
        XCTAssertEqualWithAccuracy(avg, 2, ThreeSigma, "\(avg)");
        XCTAssertTrue(min >= -1, "min was: \(min)")
        XCTAssertTrue(max < 5, "max was: \(max)")
    }
    
    func test_uniform_min_max_3() {
        var sum = 0.0
        var min = Double(Int.max)
        var max = 0.0
        for var i = 0; i < NumberOfIterations; ++i {
            var value = Rng.uniformMin(-3, max: 3)
            min = (value < min) ? value : min
            max = (value > max) ? value : max
            sum += value
        }
        let avg = sum/Double(NumberOfIterations)
        XCTAssertEqualWithAccuracy(avg, 0, ThreeSigma, "\(avg)");
        XCTAssertTrue(min >= -3, "min was: \(min)")
        XCTAssertTrue(max < 3, "max was: \(max)")
    }

}
