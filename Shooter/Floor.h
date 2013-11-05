//
//  Floor.h
//  Shooter
//
//  Created by Sven A. Schmidt on 05/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CollisionHandling.h"


@interface Floor : NSObject<CollisionHandling>

+ (instancetype)floorAtHeight:(CGFloat)height inScene:(SKScene *)scene;

@end
