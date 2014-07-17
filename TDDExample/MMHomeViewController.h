//
// Created by Marek Moscichowski on 17/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMStubImageService;
@protocol MMImageService;


@interface MMHomeViewController : UIViewController

@property(nonatomic, strong) id <MMImageService> imageService;
@end