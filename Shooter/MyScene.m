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
#import "Snowflake.h"
#import "SnowMachine.h"


static const CGFloat FlameYOffset = 100;
static const CGFloat SnowInitialBirthRate = 20;


@implementation MyScene {
    BOOL _gameIsRunning;
    Floor *_floor;
    Flame *_flame;
    SKLabelNode *_intro;
    SKLabelNode *_time;
}


-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];

        _gameIsRunning = NO;

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
            _time.fontColor = [SKColor orangeColor];
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

        { // play no_sound to init audio system
            [self runAction:[SKAction playSoundFileNamed:@"no_sound.m4a" waitForCompletion:NO]];
        }

        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
    }
    return self;
}


- (BOOL)isGameOver
{
    return _floor.maxHeight >= _flame.bottomEdgeY;
}


- (void)endGame:(CFTimeInterval)survivalTime
{
    _gameIsRunning = NO;
    NSLog(@"GAME OVER!");
    [SnowMachine stop];

    SKAction *bubbleUp = [SKAction sequence:@[
                                          [SKAction scaleTo:1.4 duration:0.3],
                                          [SKAction scaleTo:0.8 duration:0.1],
                                          [SKAction scaleTo:1.2 duration:0.1],
                                          [SKAction scaleTo:0.9 duration:0.1],
                                          [SKAction scaleTo:1.0 duration:0.1],
                                          ]];

    { // present game over label
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = @"GAME OVER!";
        label.fontColor = [SKColor orangeColor];
        label.fontSize = 30;
        label.position = CGPointMake(CGRectGetMidX(self.frame),
                                     CGRectGetMidY(self.frame));
        [label setScale:0];
        [label runAction:bubbleUp];
        [self addChild:label];
    }
    { // score label
        SKLabelNode *score1 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        score1.fontSize = 18;
        SKLabelNode *score2 = [score1 copy];
        score1.text = @"You survived for";
        score2.text = [NSString stringWithFormat:@"%.1f seconds!", survivalTime];
        score1.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame) - 40);
        score2.position = CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame) - 70);
        [score1 setScale:0];
        [score2 setScale:0];

        [score1 runAction:[SKAction sequence:@[[SKAction waitForDuration:1], bubbleUp]]];
        [score2 runAction:[SKAction sequence:@[[SKAction waitForDuration:2], bubbleUp]]];

        [self addChild:score1];
        [self addChild:score2];
    }
    [_time runAction:[SKAction fadeOutWithDuration:0.5]];
    [self runAction:[SKAction playSoundFileNamed:@"game_over.m4a" waitForCompletion:NO]];
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
    if (! _gameIsRunning && ! [self isGameOver]) {
        { // fade out intro
            SKAction *fall = [SKAction moveByX:0 y:-self.frame.size.height duration:2];
            SKAction *fade = [SKAction fadeOutWithDuration:1];
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
        _gameIsRunning = YES;
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
    if (_gameIsRunning) {
        static CFTimeInterval startTime;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            startTime = currentTime;
        });
        CFTimeInterval survivalTime = currentTime - startTime;
        _time.text = [NSString stringWithFormat:@"%.1f", survivalTime];
        if ([self isGameOver]) {
            [self endGame:survivalTime];
        }
    }
}


@end
