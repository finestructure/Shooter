//
//  SnowMachine.m
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "SnowMachine.h"

#import "Constants.h"
#import "Rng.h"


@implementation SnowMachine


+ (SKNode *)createSnowFlakeInFrame:(CGRect)frame
{
    CGVector timeRange = CGVectorMake(2, 4);
    CGVector scaleRange = CGVectorMake(0.15, 0.4);
    CGVector xRange = CGVectorMake(0, frame.size.width);
    CGFloat openingAngle = 12*M_PI/180;
    CGVector angleRange = CGVectorMake(-openingAngle, openingAngle);

    CGFloat time = [Rng uniformRange:timeRange];
    CGFloat scale = [Rng uniformRange:scaleRange];
    CGFloat startX = [Rng uniformRange:xRange];
    CGFloat angle = [Rng uniformRange:angleRange];

    CGPoint start = CGPointMake(startX, frame.size.height+10);
    CGFloat x = frame.size.height * tan(angle) + start.x;
    CGPoint end = CGPointMake(x, 0);

    SKSpriteNode *n = [SKSpriteNode spriteNodeWithImageNamed:@"spark.png"];
    [self setupPhysics:n];
    n.position = start;
    n.size = CGSizeMake(n.size.width*scale, n.size.height*scale);
    SKAction *a = [SKAction moveTo:end duration:time];
    [n runAction:a];
    return n;
}


+ (void)setupPhysics:(SKSpriteNode *)node
{
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:node.size.width/2];
    node.physicsBody.categoryBitMask = SnowCategory;
    node.physicsBody.collisionBitMask = 0;
    node.physicsBody.contactTestBitMask = SnowCategory | FlameCategory;
}


@end
