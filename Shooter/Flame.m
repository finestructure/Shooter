//
//  Flame.m
//  Shooter
//
//  Created by Sven A. Schmidt on 06/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "Flame.h"

#import "SKEmitterNode+Util.h"


@implementation Flame


+ (instancetype)flameAtPosition:(CGPoint)position
{
    Flame *flame = [Flame emitterNodeWithParticleFileNamed:@"flame"];
    flame.position = position;
    return flame;
}


- (void)collideWith:(SKPhysicsBody *)body
{
}


@end
