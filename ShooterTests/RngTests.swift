//
//  RngTest.swift
//  Shooter
//
//  Created by Sven A. Schmidt on 12/06/2014.
//  Copyright (c) 2014 feinstruktur. All rights reserved.
//

import XCTest

let NumberOfIterations = 100000
let MaxDelta = 0.03

class RngTest: XCTestCase {
    
    func computeStats(rng:()->Double) -> (Double, Double, Double) {
        var min = Double(Int.max)
        var max = Double(Int.min)
        var sum = 0.0
        for var i = 0; i < NumberOfIterations; ++i {
            var value = rng()
            min = (value < min) ? value : min
            max = (value > max) ? value : max
            sum += value
        }
        let avg = sum/Double(NumberOfIterations)
        return (min, max, avg)
    }
    
    func test_uniform_1() {
        let (min, max, avg) = computeStats {
            Rng.uniform()
        }
        XCTAssertEqualWithAccuracy(avg, 0.5, MaxDelta, "avg was: \(avg)")
        XCTAssertTrue(min >= 0, "min was: \(min)")
        XCTAssertTrue(max < 1, "max was: \(max)")
    }
    
    func test_uniform_2() {
        let (min, max, avg) = computeStats {
            Rng.uniform(5)
        }
        XCTAssertEqualWithAccuracy(avg, 2.5, MaxDelta, "avg was: \(avg)");
        XCTAssertTrue(min >= 0, "min was: \(min)")
        XCTAssertTrue(max < 5, "max was: \(max)")
    }
    
    func test_uniform_min_max_1() {
        let (min, max, avg) = computeStats {
            Rng.uniformMin(2, max: 6)
        }
        XCTAssertEqualWithAccuracy(avg, 4, MaxDelta, "avg was: \(avg)");
        XCTAssertTrue(min >= 2, "min was: \(min)")
        XCTAssertTrue(max < 6, "max was: \(max)")
    }
    
    func test_uniform_min_max_2() {
        let (min, max, avg) = computeStats {
            Rng.uniformMin(-1, max: 5)
        }
        XCTAssertEqualWithAccuracy(avg, 2, MaxDelta, "avg was: \(avg)");
        XCTAssertTrue(min >= -1, "min was: \(min)")
        XCTAssertTrue(max < 5, "max was: \(max)")
    }
    
    func test_uniform_min_max_3() {
        let (min, max, avg) = computeStats {
            Rng.uniformMin(-3, max: 3)
        }
        XCTAssertEqualWithAccuracy(avg, 0, MaxDelta, "avg was: \(avg)");
        XCTAssertTrue(min >= -3, "min was: \(min)")
        XCTAssertTrue(max < 3, "max was: \(max)")
    }

}
