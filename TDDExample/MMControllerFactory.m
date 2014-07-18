//
// Created by Marek Moscichowski on 17/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import "MMControllerFactory.h"
#import "MMHomeViewController.h"
#import "MMServiceFactory.h"


@implementation MMControllerFactory {

}
- (id)initWithServiceFactory:(id <MMServiceFactory>)serviceFactory {
  self = [super init];
  if (self) {
    self.serviceFactory = serviceFactory;
  }

  return self;
}

- (MMHomeViewController *)getHomeController {
  MMHomeViewController *controller = [MMHomeViewController new];
  controller.imageService = [self.serviceFactory getImageService];
  return controller;
}
@end