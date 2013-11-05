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


static const CGFloat GrowthBase = 0.5;
static const CGFloat GrowthSizeFraction = 1/40;
static const int GrowthSpread = 6;
static const CGFloat DampeningFactory = 0.8;


@implementation FloorSegment

+ (instancetype)floorSegmentWithRect:(CGRect)rect
{
    FloorSegment *segment = [[FloorSegment alloc] init];
    segment.position = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));

    segment.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rect.size];
    segment.physicsBody.dynamic = NO;
    segment.physicsBody.categoryBitMask = FloorCategory;

    return segment;
}


- (void)collideWith:(SKPhysicsBody *)body
{
    if ([body.node isKindOfClass:[Snowflake class]]) {
        Snowflake *flake = (Snowflake *)body.node;
        [flake hasLanded];

        CGFloat growth = GrowthBase + flake.size.height * GrowthSizeFraction;
        [self growBy:growth];

        // spread the growth to adjacent segments to get a smoother distribution
        FloorSegment *prev = self.previous;
        FloorSegment *next = self.next;
        for (int i = 0; i < GrowthSpread; ++i) {
            growth *= DampeningFactory;
            [prev growBy:growth];
            [next growBy:growth];
            prev = prev.previous;
            next = next.next;
        }
    }
}


- (void)growBy:(CGFloat)growth
{
    if (! [self hasActions]) {
        NSTimeInterval duration = 0.1;
        SKAction *move = [SKAction moveByX:0 y:growth duration:duration];
        [self runAction:move];
    }
}


@end
