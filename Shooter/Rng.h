//
//  Rng.h
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface Rng : NSObject

+ (double)uniform;
+ (double)uniform:(double)max;
+ (double)uniformMin:(double)min max:(double)max;
+ (double)uniformRange:(CGVector)range;

@end
