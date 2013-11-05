//
//  FloorSegment.h
//  Shooter
//
//  Created by Sven A. Schmidt on 05/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CollisionHandling.h"

@interface FloorSegment : SKSpriteNode<CollisionHandling>

+ (instancetype)floorSegmentWithRect:(CGRect)rect;

@end
