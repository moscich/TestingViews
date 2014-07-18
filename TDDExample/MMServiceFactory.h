//
// Created by Marek Moscichowski on 17/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol MMImageService;

@protocol MMServiceFactory <NSObject>
- (id <MMImageService>)getImageService;
@end