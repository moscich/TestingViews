//
//  MMAppDelegate.m
//  TDDExample
//
//  Created by Marek Moscichowski on 14/07/14.
//  Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import "MMAppDelegate.h"

@implementation MMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  if (NSClassFromString(@"XCTest") != nil)
    return YES;
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  return YES;
}

@end