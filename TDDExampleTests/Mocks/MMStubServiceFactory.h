//
// Created by Marek Moscichowski on 17/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMServiceFactory.h"


@interface MMStubServiceFactory : NSObject <MMServiceFactory>
@property(nonatomic, strong) id stubService;
@end