//
// Created by Marek Moscichowski on 17/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import "MMMockedImageService.h"


@implementation MMMockedImageService {

}
- (void)getImages:(void (^)(NSArray *))callback {
  callback(@[
          [UIImage imageNamed:@"image1.jpg"],
          [UIImage imageNamed:@"image2.jpg"],
          [UIImage imageNamed:@"image3.jpg"],
          [UIImage imageNamed:@"image4.jpg"]]);
}

@end