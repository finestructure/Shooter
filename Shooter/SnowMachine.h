//
//  SnowMachine.h
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Snowflake;
@class SKScene;

@interface SnowMachine : NSObject

+ (void)startInScene:(SKScene *)scene;
+ (void)stop;

+ (Snowflake *)createSnowFlakeInScene:(SKScene *)scene;

@end
