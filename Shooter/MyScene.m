//
//  MyScene.m
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "MyScene.h"

#import "SKEmitterNode+Util.h"


static const CGFloat FlameYOffset = 40;


@implementation MyScene {
    SKNode *_flame;
}



-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        _flame = [SKEmitterNode emitterNodeWithParticleFileNamed:@"Flame"];
        _flame.position = CGPointMake(CGRectGetMidX(self.frame), FlameYOffset);
        [self addChild:_flame];

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
    /* Called before each frame is rendered */
}


@end
