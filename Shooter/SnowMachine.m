//
//  SnowMachine.m
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "SnowMachine.h"

#import "Rng.h"


@implementation SnowMachine


+ (SKNode *)createSnowFlakeInFrame:(CGRect)frame
{
    CGFloat time = 2;
    CGPoint start = CGPointMake(CGRectGetMidX(frame), frame.size.height-10);
    CGFloat angleRange = 12*M_PI/180;
    CGFloat scale = 0.2;

    CGFloat angle = [Rng uniformMin:-angleRange max:angleRange];
    CGFloat x = frame.size.height * tan(angle) + start.x;
    CGPoint end = CGPointMake(x, 0);

    SKSpriteNode *n = [SKSpriteNode spriteNodeWithImageNamed:@"spark.png"];
    n.position = start;
    n.size = CGSizeMake(n.size.width*scale, n.size.height*scale);
    SKAction *a = [SKAction moveTo:end duration:time];
    [n runAction:a];
    return n;
}


@end
