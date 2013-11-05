//
//  Floor.m
//  Shooter
//
//  Created by Sven A. Schmidt on 05/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "Floor.h"

#import "FloorSegment.h"

const NSUInteger NumberOfSegments = 32;


@implementation Floor {
    NSMutableArray *_segments;
}


+ (instancetype)floorAtHeight:(CGFloat)height inScene:(SKScene *)scene
{
    return [[self alloc] initAtHeight:height inScene:scene];
}


- (id)initAtHeight:(CGFloat)height inScene:(SKScene *)scene
{
    self = [super init];
    if (self) {
        // Because we will grow the segments we create them much higher than necessary and push them
        // beyond the bottom edge. That way we don't have to resize them and avoid flickering at the bottom.
        CGFloat negativeOffset = scene.size.height;

        NSAssert((NSUInteger)scene.size.width % NumberOfSegments == 0,
                 @"Width must be divisible by number of segments");
        CGFloat segmentWidth = scene.size.width / NumberOfSegments;

        _segments = [NSMutableArray arrayWithCapacity:NumberOfSegments];
        for (int i = 0; i < NumberOfSegments; ++i) {
            CGFloat x = i * segmentWidth;
            CGFloat y = -negativeOffset;
            CGRect rect = CGRectMake(x, y,
                                     segmentWidth, height + negativeOffset);
            FloorSegment *s = [FloorSegment floorSegmentWithRect:rect];
            s.previous = [_segments lastObject];
            s.previous.next = s;
            [_segments addObject:s];
            [scene addChild:s];
        }
    }
    return self;
}


@end
