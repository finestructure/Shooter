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
#import "Snowflake.h"


static const CGFloat InitialFlakesPerSecond = 5;
static const CGFloat IncreasePerSecond = 4;
static const NSUInteger ChildCountThrottleLimit = 500;


@interface SnowMachine ()

@property (nonatomic) SKScene *scene;

@end


@implementation SnowMachine {
    NSTimer *_timer;
}


+ (instancetype)sharedInstance
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


+ (void)startInScene:(SKScene *)scene
{
    SnowMachine *machine = [self sharedInstance];
    machine.scene = scene;
    [machine start];
}


- (void)start
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(snow) userInfo:nil repeats:YES];
}


- (void)snow
{
    static CGFloat flakesPerSecond = InitialFlakesPerSecond;
    NSLog(@"flakesPerSecond: %.0f", flakesPerSecond);
    double delayInSeconds = 1./flakesPerSecond;

    NSLog(@"node count: %lu", (unsigned long)self.scene.children.count);

    for (int i = 0; i < flakesPerSecond; ++i) {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (self.scene.children.count < ChildCountThrottleLimit) {
                SKNode *n = [SnowMachine createSnowFlakeInScene:self.scene];
                [self.scene addChild:n];
            } else {
                flakesPerSecond -= 1;
            }
        });
    }
    if (self.scene.children.count < ChildCountThrottleLimit) {
        flakesPerSecond += IncreasePerSecond;
    }
}


+ (Snowflake *)createSnowFlakeInScene:(SKScene *)scene
{
    CGVector timeRange = CGVectorMake(2, 4);
    CGVector scaleRange = CGVectorMake(0.15, 0.4);
    CGVector xRange = CGVectorMake(0, scene.size.width);
    CGFloat openingAngle = 12*M_PI/180;
    CGVector angleRange = CGVectorMake(-openingAngle, openingAngle);

    CGFloat time = [Rng uniformRange:timeRange];
    CGFloat scale = [Rng uniformRange:scaleRange];
    CGFloat startX = [Rng uniformRange:xRange];
    CGFloat angle = [Rng uniformRange:angleRange];

    CGPoint start = CGPointMake(startX, scene.size.height+10);
    CGFloat x = scene.size.height * tan(angle) + start.x;
    CGPoint end = CGPointMake(x, 0);

    Snowflake *n = [Snowflake snowflakeWithScale:scale];
    n.position = start;
    SKAction *move = [SKAction moveTo:end duration:time];
    SKAction *remove = [SKAction removeFromParent];
    [n runAction:[SKAction sequence:@[move, remove]]];
    return n;
}


@end
