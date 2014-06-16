//
//  Flame.m
//  Shooter
//
//  Created by Sven A. Schmidt on 06/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "Flame.h"

#import "Collider.h"
#import "Constants.h"
#import "FloorSegment.h"
#import "Snowflake.h"
#import "Shooter-Swift.h"


@implementation Flame


+ (instancetype)flameAtPosition:(CGPoint)position
{
    // we need to map SKEmitterNode to Flame before unarchiving
    [NSKeyedUnarchiver setClass:self forClassName:@"SKEmitterNode"];
    Flame *flame = (Flame *)[Flame emitterNodeWithParticleFileNamed:@"flame"];

    flame.position = position;
    flame.name = @"Flame";
    
    flame.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(24, 110)];
    flame.physicsBody.dynamic = NO;
    flame.physicsBody.categoryBitMask = FlameCategory;

    return flame;
}


- (void)collideWith:(SKPhysicsBody *)body
{
    if ([body.node isKindOfClass:[Snowflake class]]) {
        [Collider collideSnowflake:(Snowflake *)body.node withFlame:self];
    }
}


- (CGFloat)bottomEdgeY
{
    // the emitter sits above the base, this is just a number that works well as the "touch point" for the snow
    return self.frame.origin.y + 40;
}


@end
