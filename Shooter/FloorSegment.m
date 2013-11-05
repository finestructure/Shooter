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
    if ([body.node isKindOfClass:[Snowflake class]]) {
        Snowflake *flake = (Snowflake *)body.node;
        [flake hasLanded];

        CGFloat growth = flake.size.height/20;
        [self growBy:growth];
        [self.previous growBy:growth/2];
        [self.previous.previous growBy:growth/3];
        [self.next growBy:growth/2];
        [self.next.next growBy:growth/3];
    }
}


- (void)growBy:(CGFloat)groth
{
    NSTimeInterval duration = 0.1;
    SKAction *move = [SKAction moveByX:0 y:groth duration:duration];
    [self runAction:move];
}


@end
