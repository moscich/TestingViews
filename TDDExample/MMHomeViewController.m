//
// Created by Marek Moscichowski on 17/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import "MMHomeViewController.h"
#import "MMHomeView.h"
#import "MMStubImageService.h"

@implementation MMHomeViewController {

}

- (void)viewDidLoad {
  [self.imageService getImages:^(NSArray *images){
    NSArray *imageViews = ((MMHomeView *)self.view).imageViews;
    for(int i = 0; i < images.count; i++){
      UIImageView *imageView = imageViews[(NSUInteger) i];
      UIImage *image = images[(NSUInteger) i];
      imageView.image = image;
    }
  }];
}

@end