//
//  Rng.m
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "Rng.h"


@implementation Rng


+ (double)uniform
{
   return (double)arc4random() / UINT32_MAX;
}


+ (double)uniform:(double)max
{
    return [self uniform]*max;
}


+ (double)uniformMin:(double)min max:(double)max
{
    return [self uniform:(max - min)] - min;
}


@end
