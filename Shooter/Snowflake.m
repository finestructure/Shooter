//
//  Snowflake.m
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "Snowflake.h"

#import "Constants.h"

@implementation Snowflake

+ (instancetype)snowflakeWithScale:(CGFloat)scale
{
    Snowflake *node = [Snowflake spriteNodeWithImageNamed:@"spark.png"];
    node.size = CGSizeMake(node.size.width*scale, node.size.height*scale);
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:node.size.width/2];
    node.physicsBody.categoryBitMask = SnowCategory;
    node.physicsBody.collisionBitMask = FloorCategory;
    node.physicsBody.contactTestBitMask = FlameCategory | FloorCategory;
    return node;
}

- (void)collideWith:(SKPhysicsBody *)body
{
    NSLog(@"snowflake hit: %@", body);
    [self removeAllActions];
}

@end
