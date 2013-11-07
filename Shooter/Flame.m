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
#import "SKEmitterNode+Util.h"
#import "Snowflake.h"


@implementation Flame


+ (instancetype)flameAtPosition:(CGPoint)position
{
    // we need to map SKEmitterNode to Flame before unarchiving
    [NSKeyedUnarchiver setClass:self forClassName:@"SKEmitterNode"];
    Flame *flame = [Flame emitterNodeWithParticleFileNamed:@"flame"];

    flame.position = position;
    flame.name = @"Flame";
    
    flame.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(32*2, 120*2)];
    flame.physicsBody.dynamic = NO;
    flame.physicsBody.categoryBitMask = FlameCategory;

    return flame;
}


- (void)collideWith:(SKPhysicsBody *)body
{
    NSLog(@"flame hit: %@", [body class]);
    if ([body.node isKindOfClass:[Snowflake class]]) {
        [Collider collideSnowflake:(Snowflake *)body.node withFlame:self];
    }
}


@end
