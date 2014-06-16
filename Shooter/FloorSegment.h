//
//  FloorSegment.h
//  Shooter
//
//  Created by Sven A. Schmidt on 05/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Shooter-Swift.h"


@class Snowflake;


@interface FloorSegment : SKNode<CollisionHandling>

+ (instancetype)floorSegmentWithRect:(CGRect)rect;

- (void)absorbSnowflake:(Snowflake *)flake;

@property (nonatomic) FloorSegment *next;
@property (nonatomic) FloorSegment *previous;
@property (nonatomic, readonly) CGFloat visibleHeight;

@end
