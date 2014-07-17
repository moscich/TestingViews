//
//  MMControllerFactoryTests.m
//  TDDExample
//
//  Created by Marek Moscichowski on 17/07/14.
//  Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MMControllerFactory.h"
#import "MMHomeViewController.h"
#import "MMStubServiceFactory.h"

@interface MMControllerFactoryTests : XCTestCase

@end

@implementation MMControllerFactoryTests

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

- (void)testFactoryCreatesHomeControllerWithServiceFromServiceFactory {
  id stubImageService = [NSObject new];
  MMStubServiceFactory *stubServiceFactory = [MMStubServiceFactory new];
  stubServiceFactory.stubService = stubImageService;
  MMControllerFactory *controllerFactory = [[MMControllerFactory alloc] initWithServiceFactory:stubServiceFactory];
  MMHomeViewController *controller = [controllerFactory getHomeController];
  XCTAssertEqual(controller.imageService, stubImageService);
}

@end
