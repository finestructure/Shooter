//
//  MyScene.m
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "MyScene.h"

#import "Constants.h"
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

        self.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 0)
                                                        toPoint:CGPointMake(self.frame.size.width, 0)];
        self.physicsBody.dynamic = NO;
        self.physicsBody.categoryBitMask = WallCategory;

        { // flame
            _flame = [SKEmitterNode emitterNodeWithParticleFileNamed:@"flame"];
            _flame.position = CGPointMake(CGRectGetMidX(self.frame), FlameYOffset);
            [self addChild:_flame];
        }

        { // snowflakes
            for (int i = 0; i < 50; ++i) {
                SKNode *n = [SnowMachine createSnowFlakeInFrame:self.frame];
                [self addChild:n];
            }
        }

        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;

    }
    return self;
}


#pragma mark - SKPhysicsContactDelegate


- (void)didBeginContact:(SKPhysicsContact *)contact
{
//    SKPhysicsBody *firstBody, *secondBody;
//
//    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
//    {
//        firstBody = contact.bodyA;
//        secondBody = contact.bodyB;
//    }
//    else
//    {
//        firstBody = contact.bodyB;
//        secondBody = contact.bodyA;
//    }
//    if ((firstBody.categoryBitMask & missileCategory) != 0)
//    {
//        [self attack: secondBody.node withMissile:firstBody.node];
//    }

}


#pragma mark - Touches


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
}


@end
