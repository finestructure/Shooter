//
//  Floor.h
//  Shooter
//
//  Created by Sven A. Schmidt on 05/11/2013.
//  Copyright (c) 2013 feinstruktur. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKScene;

@interface Floor : NSObject

+ (instancetype)floorAtHeight:(CGFloat)height inScene:(SKScene *)scene;

- (CGFloat)maxHeight;

@end
