//
// Created by Marek Moscichowski on 17/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import "MMStubServiceFactory.h"
#import "MMImageService.h"


@implementation MMStubServiceFactory {

}
- (id <MMImageService>)getImageService {
  return self.stubService;
}

@end