//
//  Snowflake.m
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "Snowflake.h"

#import "Collider.h"
#import "Constants.h"
#import "Flame.h"
#import "FloorSegment.h"
#import "SKEmitterNode+Util.h"


@implementation Snowflake

+ (instancetype)snowflakeWithScale:(CGFloat)scale
{
    Snowflake *node = [Snowflake spriteNodeWithImageNamed:@"spark.png"];
    node.size = CGSizeMake(node.size.width*scale, node.size.height*scale);
    node.name = @"Snowflake";
    
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:node.size.width/2*0.3];
    node.physicsBody.categoryBitMask = SnowCategory;
    node.physicsBody.collisionBitMask = FlameCategory | FloorCategory;
    node.physicsBody.contactTestBitMask = FlameCategory | FloorCategory;
    
    return node;
}


- (void)hasLanded
{
    [self removeAllActions];
    self.physicsBody = nil;
    SKAction *fade = [SKAction fadeOutWithDuration:12];
    SKAction *remove = [SKAction removeFromParent];
    [self runAction:[SKAction sequence:@[fade, remove]]];
}


- (void)evaporate
{
    [self removeAllActions];

    SKEmitterNode *steam = [SKEmitterNode emitterNodeWithParticleFileNamed:@"steam"];

    SKAction *remove = [SKAction removeFromParent];

    SKAction *puff = [SKAction runBlock:^{
        steam.position = self.position;
        [self.scene addChild:steam];
        SKAction *wait = [SKAction waitForDuration:1];
        [steam runAction:[SKAction sequence:@[wait, remove]]];
    }];

    [self runAction:[SKAction sequence:@[puff, remove]]];
}


- (void)collideWith:(SKPhysicsBody *)body
{
    if ([body.node isKindOfClass:[FloorSegment class]]) {
        [Collider collideSnowflake:self withFloorSegment:(FloorSegment *)body.node];
    } else if ([body.node isKindOfClass:[Flame class]]) {
        [Collider collideSnowflake:self withFlame:(Flame *)body.node];
    }
}

@end
