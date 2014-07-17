//
//  MMMockedServiceTests.m
//  StubTDDExample Unit tests
//
//  Created by Marek Moscichowski on 17/07/14.
//  Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MMMockedServiceFactory.h"
#import "MMMockedImageService.h"

@interface MMMockedServiceTests : XCTestCase

@end

@implementation MMMockedServiceTests

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

- (void)testMockServiceFactoryReturnsMockImageService
{
  MMMockedServiceFactory *mockedServiceFactory = [MMMockedServiceFactory new];
  XCTAssertTrue([[mockedServiceFactory getImageService] conformsToProtocol:@protocol(MMImageService)]);
}

- (void)testMockedServiceReturnsImagesFromAssets {
  MMMockedImageService *mockedImageService = [MMMockedImageService new];
  __block NSArray *images;
  [mockedImageService getImages:^(NSArray *array) {
    images = array;
  }];
  for (int i = 0; i < 4; i++) {
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%i.jpg", i+1]];
    XCTAssertEqualObjects(image, images[i]);
  }
}

@end
