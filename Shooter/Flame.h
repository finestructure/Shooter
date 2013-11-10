//
//  Flame.h
//  Shooter
//
//  Created by Sven A. Schmidt on 06/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CollisionHandling.h"


@interface Flame : SKEmitterNode <CollisionHandling>

+ (instancetype)flameAtPosition:(CGPoint)position;

@property (nonatomic, readonly) CGFloat bottomEdgeY;

@end
