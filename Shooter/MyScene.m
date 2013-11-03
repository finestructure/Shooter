//
//  MyScene.m
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "MyScene.h"

#import "SKEmitterNode+Util.h"
#import "SnowMachine.h"


static const CGFloat FlameYOffset = 100;
static const CGFloat SnowInitialBirthRate = 20;


@implementation MyScene {
    SKNode *_flame;
}


-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];

        { // flame
            _flame = [SKEmitterNode emitterNodeWithParticleFileNamed:@"flame"];
            _flame.position = CGPointMake(CGRectGetMidX(self.frame), FlameYOffset);
            [self addChild:_flame];
        }

        { // snow
            for (int i = 0; i < 100; ++i) {
                SKNode *n = [SnowMachine createSnowFlakeInFrame:self.frame];
                [self addChild:n];
            }
        }
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (int i = 0; i < 100; ++i) {
        SKNode *n = [SnowMachine createSnowFlakeInFrame:self.frame];
        [self addChild:n];
    }
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newLoc = CGPointMake(location.x, _flame.position.y);
        _flame.position = newLoc;
    }
}


-(void)update:(CFTimeInterval)currentTime {
    static CFTimeInterval startTime;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        startTime = currentTime;
    });
    // scale the snow birthrate with the current time
    CFTimeInterval newBirthRate = SnowInitialBirthRate + (currentTime - startTime);
//    NSLog(@"br: %.1f", newBirthRate);
//    _snow.particleBirthRate = newBirthRate;
}


@end
