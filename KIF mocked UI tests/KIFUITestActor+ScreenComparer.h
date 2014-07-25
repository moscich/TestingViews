//
// Created by Marek Moscichowski on 14/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KIFUITestActor.h"

@interface KIFUITestActor (ScreenComparer)
- (void)compareCurrentScreenWithReferenceImageNamed:(NSString *)imageName withMaskNamed:(NSString *)maskName;
@end