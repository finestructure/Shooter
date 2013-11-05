//
//  Floor.m
//  Shooter
//
//  Created by Sven A. Schmidt on 05/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "Floor.h"

#import "FloorSegment.h"


@implementation Floor {
    SKNode *_segment;
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
        _segment = [FloorSegment floorSegmentWithRect:CGRectMake(0, -negativeOffset,
                                                                 scene.size.width, height + negativeOffset)];
        [scene addChild:_segment];
    }
    return self;
}


@end
