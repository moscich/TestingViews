//
// Created by Marek Moscichowski on 17/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import "MMMockedServiceFactory.h"
#import "MMMockedImageService.h"


@implementation MMMockedServiceFactory {

}
- (id <MMImageService>)getImageService {
  return [MMMockedImageService new];
}

@end