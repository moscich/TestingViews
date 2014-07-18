//
// Created by Marek Moscichowski on 17/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMImageService.h"


@interface MMStubImageService : NSObject <MMImageService>

@property (nonatomic, strong) NSArray *mockArray;

- (id)initWithImages:(NSArray *)array;

@end