//
//  Collider.h
//  Shooter
//
//  Created by Sven A. Schmidt on 06/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FloorSegment;
@class Snowflake;

@interface Collider : NSObject

+ (void)collideSnowflake:(Snowflake *)flake withFloorSegment:(FloorSegment *)floorSegment;

@end
