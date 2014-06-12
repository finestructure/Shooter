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
    var avg: Double?
    var min: Double?
    var max: Double?
    
    override func setUp() {
        avg = nil
        min = Double(Int.max)
        max = Double(Int.min)
    }
    
    func computeStats(rng:()->Double) {
        var sum = 0.0
        for var i = 0; i < NumberOfIterations; ++i {
            var value = rng()
            min = (value < min) ? value : min
            max = (value > max) ? value : max
            sum += value
        }
        avg = sum/Double(NumberOfIterations)
    }
    
    func test_uniform_1() {
        computeStats {
            Rng.uniform()
        }
        XCTAssertEqualWithAccuracy(avg!, 0.5, ThreeSigma, "\(avg)")
        XCTAssertTrue(min >= 0, "min was: \(min)")
        XCTAssertTrue(max < 1, "max was: \(max)")
    }
    
    func test_uniform_2() {
        computeStats {
            Rng.uniform(5)
        }
        XCTAssertEqualWithAccuracy(avg!, 2.5, ThreeSigma, "\(avg)");
        XCTAssertTrue(min >= 0, "min was: \(min)")
        XCTAssertTrue(max < 5, "max was: \(max)")
    }
    
    func test_uniform_min_max_1() {
        computeStats {
            Rng.uniformMin(2, max: 6)
        }
        XCTAssertEqualWithAccuracy(avg!, 4, ThreeSigma, "\(avg)");
        XCTAssertTrue(min >= 2, "min was: \(min)")
        XCTAssertTrue(max < 6, "max was: \(max)")
    }
    
    func test_uniform_min_max_2() {
        computeStats {
            Rng.uniformMin(-1, max: 5)
        }
        XCTAssertEqualWithAccuracy(avg!, 2, ThreeSigma, "\(avg)");
        XCTAssertTrue(min >= -1, "min was: \(min)")
        XCTAssertTrue(max < 5, "max was: \(max)")
    }
    
    func test_uniform_min_max_3() {
        computeStats {
            Rng.uniformMin(-3, max: 3)
        }
        XCTAssertEqualWithAccuracy(avg!, 0, ThreeSigma, "\(avg)");
        XCTAssertTrue(min >= -3, "min was: \(min)")
        XCTAssertTrue(max < 3, "max was: \(max)")
    }

}
