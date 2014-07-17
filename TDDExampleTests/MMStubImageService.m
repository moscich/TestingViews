//
// Created by Marek Moscichowski on 17/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import "MMStubImageService.h"


@implementation MMStubImageService {

}

- (id)initWithImages:(NSArray *)array {

  self = [super init];
  if (self) {
    self.mockArray = array;
  }

  return self;
}

- (void)getImages:(void (^)(NSArray *))callback {
  callback(self.mockArray);
}


@end