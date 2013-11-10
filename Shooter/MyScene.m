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
#import "Flame.h"
#import "Floor.h"
#import "SKEmitterNode+Util.h"
#import "Snowflake.h"
#import "SnowMachine.h"


static const CGFloat FlameYOffset = 100;
static const CGFloat SnowInitialBirthRate = 20;


@implementation MyScene {
    BOOL _started;
    Floor *_floor;
    Flame *_flame;
    SKLabelNode *_intro;
    SKLabelNode *_time;
}


-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];

        _started = NO;

        { // description
            _intro = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
            _intro.text = @"Touch to start";
            _intro.fontSize = 24;
            _intro.position = CGPointMake(CGRectGetMidX(self.frame),
                                           self.frame.size.height - 100);
            [self addChild:_intro];
        }

        { // time
            _time = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
            _time.text = @"";
            _time.fontSize = 16;
            _time.position = CGPointMake(20, self.frame.size.height - 40);
            _time.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
            _time.alpha = 0;
            [self addChild:_time];
        }

        { // floor
            _floor = [Floor floorAtHeight:50 inScene:self];
        }

        { // flame
            _flame = [Flame flameAtPosition:CGPointMake(CGRectGetMidX(self.frame), FlameYOffset)];
            [self addChild:_flame];
        }

        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
    }
    return self;
}


- (BOOL)isGameOver
{
//    NSLog(@"floor: 0.%f", _floor.maxHeight);
    return _floor.maxHeight >= _flame.bottomEdgeY;
}


- (void)endGame
{
    NSLog(@"GAME OVER!");
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
    }
}


#pragma mark - Touches


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (! _started) {
        { // fade out intro
            SKAction *fall = [SKAction moveByX:0 y:-self.frame.size.height duration:2];
            SKAction *fade = [SKAction fadeOutWithDuration:1.5];
            SKAction *remove = [SKAction removeFromParent];
            SKAction *fadeAndRemove = [SKAction sequence:@[fade, remove]];
            SKAction *group = [SKAction group:@[fall, fadeAndRemove]];
            [_intro runAction:group];
        }
        { // fade in time
            SKAction *fade = [SKAction fadeInWithDuration:1.5];
            [_time runAction:fade];
        }
        [SnowMachine startInScene:self];
        _started = YES;
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
    if (_started) {
        static CFTimeInterval startTime;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            startTime = currentTime;
        });
        _time.text = [NSString stringWithFormat:@"%.1f", currentTime - startTime];
        if ([self isGameOver]) {
            [self endGame];
        }
    }
}


@end
