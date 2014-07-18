//
//  MMHomeScreenTests.m
//  TDDExample
//
//  Created by Marek Moscichowski on 15/07/14.
//  Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MMHomeViewController.h"
#import "MMHomeView.h"
#import "MMStubImageService.h"

@interface MMHomeScreenTests : XCTestCase

@end

@implementation MMHomeScreenTests

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

- (void)testControllerFetchImagesFromServiceAndPopulateItsView {
  NSArray *mockedImages = @[[UIImage new], [UIImage new], [UIImage new], [UIImage new]];
  MMHomeViewController *homeController = [MMHomeViewController new];
  homeController.imageService = [[MMStubImageService alloc] initWithImages:mockedImages];
  [homeController viewDidLoad];

  for (int i = 0; i < 4; i++)
    XCTAssertEqualObjects(((UIImageView *) ((MMHomeView *) homeController.view).imageViews[i]).image, mockedImages[i]);
}

- (void)testHomeViewTextFieldAreVisibleWhenKeyboarAppears {
  MMHomeViewController *homeController = [MMHomeViewController new];
  [homeController viewDidLoad];

  NSDictionary *notificationObject = @{UIKeyboardFrameEndUserInfoKey: [NSValue valueWithCGRect:CGRectMake(0, 264, 320, 216)]};
  NSNotification *keyboardNotification = [NSNotification notificationWithName:UIKeyboardWillShowNotification object:notificationObject];

  [((MMHomeView *) homeController.view) keyboardWillBeShown:keyboardNotification];
  XCTAssertTrue(-96 <= ((MMHomeView *)homeController.view).topMarginConstraint.constant);
}

@end
