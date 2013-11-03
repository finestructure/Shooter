//
//  SnowMachine.h
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Snowflake;

@interface SnowMachine : NSObject

+ (Snowflake *)createSnowFlakeInFrame:(CGRect)frame;

@end
