//
//  FloorSegment.m
//  Shooter
//
//  Created by Sven A. Schmidt on 05/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "FloorSegment.h"

#import "Constants.h"
#import "Snowflake.h"


@implementation FloorSegment

+ (instancetype)floorSegmentWithRect:(CGRect)rect
{
    FloorSegment *segment = [FloorSegment spriteNodeWithColor:[UIColor whiteColor] size:rect.size];
    segment.position = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    segment.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rect.size];
    segment.physicsBody.dynamic = NO;
    segment.physicsBody.categoryBitMask = FloorCategory;
    return segment;
}


- (void)collideWith:(SKPhysicsBody *)body
{
    NSLog(@"floor segment");
    if ([body.node isKindOfClass:[Snowflake class]]) {
        Snowflake *flake = (Snowflake *)body.node;
        [flake hasLanded];

        CGFloat growBy = flake.size.height/5;
        NSTimeInterval duration = 0.5;
        SKAction *move = [SKAction moveByX:0 y:growBy duration:duration];
        [self runAction:move];
    }
}


@end
