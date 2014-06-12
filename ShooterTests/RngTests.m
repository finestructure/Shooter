//
//  RngTests.m
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Rng.h"


static const NSUInteger NumberOfIterations = 10000;
static const double ThreeSigma = 3/100.;

@interface RngTests : XCTestCase

@end


@implementation RngTests


- (void)test_uniform
{
    double sum = 0;
    double min = UINT32_MAX;
    double max = 0;
    for (int i = 0; i < NumberOfIterations; ++i) {
        double value = [Rng uniform];
        min = (value < min) ? value : min;
        max = (value > max) ? value : max;
        sum += value;
    }
    double avg = sum/NumberOfIterations;
    XCTAssertEqualWithAccuracy(avg, 0.5, ThreeSigma, @"");
    XCTAssertTrue(min >= 0, @"min was: %.1f", min);
    XCTAssertTrue(max < 1, @"max was: %.1f", max);
}


- (void)test_uniform_max
{
    double sum = 0;
    double min = UINT32_MAX;
    double max = 0;
    for (int i = 0; i < NumberOfIterations; ++i) {
        double value = [Rng uniform:5];
        min = (value < min) ? value : min;
        max = (value > max) ? value : max;
        sum += value;
    }
    double avg = sum/NumberOfIterations;
    XCTAssertEqualWithAccuracy(avg, 2.5, ThreeSigma, @"");
    XCTAssertTrue(min >= 0, @"min was: %.1f", min);
    XCTAssertTrue(max < 5, @"max was: %.1f", max);
}


- (void)test_uniform_min_max_1
{
    double sum = 0;
    double min = UINT32_MAX;
    double max = 0;
    for (int i = 0; i < NumberOfIterations; ++i) {
        double value = [Rng uniformMin:2 max:6];
        min = (value < min) ? value : min;
        max = (value > max) ? value : max;
        sum += value;
    }
    double avg = sum/NumberOfIterations;
    XCTAssertEqualWithAccuracy(avg, 4, ThreeSigma, @"");
    XCTAssertTrue(min >= 2, @"min was: %.1f", min);
    XCTAssertTrue(max < 6, @"max was: %.1f", max);
}


- (void)test_uniform_min_max_2
{
    double sum = 0;
    double min = UINT32_MAX;
    double max = 0;
    for (int i = 0; i < NumberOfIterations; ++i) {
        double value = [Rng uniformMin:-1 max:5];
        min = (value < min) ? value : min;
        max = (value > max) ? value : max;
        sum += value;
    }
    double avg = sum/NumberOfIterations;
    XCTAssertEqualWithAccuracy(avg, 2, ThreeSigma, @"");
    XCTAssertTrue(min >= -1, @"min was: %.1f", min);
    XCTAssertTrue(max < 5, @"max was: %.1f", max);
}


- (void)test_uniform_min_max_3
{
    double sum = 0;
    double min = UINT32_MAX;
    double max = 0;
    for (int i = 0; i < NumberOfIterations; ++i) {
        double value = [Rng uniformMin:-3 max:3];
        min = (value < min) ? value : min;
        max = (value > max) ? value : max;
        sum += value;
    }
    double avg = sum/NumberOfIterations;
    XCTAssertEqualWithAccuracy(avg, 0, ThreeSigma, @"");
    XCTAssertTrue(min >= -3, @"min was: %.1f", min);
    XCTAssertTrue(max < 3, @"max was: %.1f", max);
}


@end
