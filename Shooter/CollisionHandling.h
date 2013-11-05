//
//  CollisionHandling.h
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>


@protocol CollisionHandling <NSObject>

- (void)collideWith:(SKPhysicsBody *)body;

@end
