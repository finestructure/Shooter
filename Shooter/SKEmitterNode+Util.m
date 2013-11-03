//
//  SKEmitterNode+Util.m
//  Shooter
//
//  Created by Sven A. Schmidt on 03/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import "SKEmitterNode+Util.h"

@implementation SKEmitterNode (Util)

+ (instancetype)emitterNodeWithParticleFileNamed:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:[name stringByDeletingPathExtension] ofType:@"sks"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

@end
