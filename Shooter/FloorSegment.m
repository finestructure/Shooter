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
    segment.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rect.size];
    segment.physicsBody.dynamic = NO;
    segment.physicsBody.categoryBitMask = FloorCategory;
    segment.position = CGPointMake(rect.size.width/2, rect.size.height/2);
    return segment;
}

- (void)collideWith:(SKPhysicsBody *)body
{
    NSLog(@"floor segment");
    if ([body.node isKindOfClass:[Snowflake class]]) {
        [(Snowflake *)body.node hasLanded];
    }
}

@end
