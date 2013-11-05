//
//  MyScene.m
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "MyScene.h"

#import "CollisionHandling.h"
#import "Constants.h"
#import "Floor.h"
#import "SKEmitterNode+Util.h"
#import "Snowflake.h"
#import "SnowMachine.h"


static const CGFloat FlameYOffset = 100;
static const CGFloat SnowInitialBirthRate = 20;


@implementation MyScene {
    Floor *_floor;
    SKNode *_flame;
}


-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];

        { // floor
            _floor = [Floor floorAtHeight:50 inScene:self];
        }

        { // flame
            _flame = [SKEmitterNode emitterNodeWithParticleFileNamed:@"flame"];
            _flame.position = CGPointMake(CGRectGetMidX(self.frame), FlameYOffset);
            [self addChild:_flame];
        }

        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
    }
    return self;
}


#pragma mark - SKPhysicsContactDelegate


- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKNode *nodeA = contact.bodyA.node;
    SKNode *nodeB = contact.bodyB.node;
    if ([nodeA respondsToSelector:@selector(collideWith:)]) {
        [(id<CollisionHandling>)nodeA collideWith:contact.bodyB];
    } else if ([nodeB respondsToSelector:@selector(collideWith:)]) {
        [(id<CollisionHandling>)nodeB collideWith:contact.bodyA];
    } else {
        // we just handle bodyA - if bodyB is not supported it will be dealt with in collideWith:
        NSAssert(NO, @"body does not support collisions: %@", contact.bodyA);
    }
}


#pragma mark - Touches


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    static BOOL firstTouch = YES;

    if (firstTouch) {
        [SnowMachine startInScene:self];
        firstTouch = NO;
    } else {
        NSUInteger count = 10;
        for (int i = 0; i < count; ++i) {
            SKNode *n = [SnowMachine createSnowFlakeInScene:self];
            [self addChild:n];
        }
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
