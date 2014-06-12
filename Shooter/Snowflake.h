//
//  Snowflake.h
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CollisionHandling.h"

@interface Snowflake : SKSpriteNode <CollisionHandling>

+ (instancetype)snowflakeWithScale:(CGFloat)scale;

- (void)hasLanded;
- (void)evaporate;

@end
