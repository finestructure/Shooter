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
        _segment = [FloorSegment floorSegmentWithRect:CGRectMake(0, 0, scene.size.width, height)];
        [scene addChild:_segment];
    }
    return self;
}


- (void)collideWith:(SKPhysicsBody *)body
{
    NSLog(@"floor collision");
}


@end
