//
//  MMAppDelegate.m
//  StubTDDExample
//
//  Created by Marek Moscichowski on 17/07/14.
//  Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import "MMAppDelegate.h"
#import "MMControllerFactory.h"
#import "MMMockedServiceFactory.h"
#import "MMHomeViewController.h"

@implementation MMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  if(NSClassFromString(@"XCTest") != nil)
    return YES;

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];

  MMControllerFactory *controllerFactory = [[MMControllerFactory alloc] initWithServiceFactory:[MMMockedServiceFactory new]];
  UIViewController *viewController = [controllerFactory getHomeController];
  self.window.rootViewController = viewController;

  return YES;
}

@end
