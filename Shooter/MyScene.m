//
//  MyScene.m
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "MyScene.h"

#import "SKEmitterNode+Util.h"


static const CGFloat FlameYOffset = 100;
static const CGFloat SnowInitialBirthRate = 20;


@implementation MyScene {
    SKNode *_flame;
    SKEmitterNode *_snow;
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
            _snow = [SKEmitterNode emitterNodeWithParticleFileNamed:@"snow"];
            _snow.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height);
            _snow.particleBirthRate = SnowInitialBirthRate;
            _snow.particlePositionRange = CGVectorMake(self.frame.size.width,
                                                       _snow.particlePositionRange.dy);
            [self addChild:_snow];
        }
    }
    return self;
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
