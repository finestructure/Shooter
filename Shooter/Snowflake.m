//
//  Snowflake.m
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "Snowflake.h"

@implementation Snowflake

- (void)collideWith:(SKPhysicsBody *)body
{
    NSLog(@"snowflake hit: %@", body);
}

@end
