//
// Created by Marek Moscichowski on 17/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMHomeViewController;
@protocol MMServiceFactory;


@interface MMControllerFactory : NSObject

@property (nonatomic, strong) id <MMServiceFactory> serviceFactory;

- (id)initWithServiceFactory:(id <MMServiceFactory>)serviceFactory;

- (MMHomeViewController *)getHomeController;

@end