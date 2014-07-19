//
//  UITests.m
//  KIF mocked UI tests
//
//  Created by Marek Moscichowski on 19/07/14.
//  Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import <KIF/KIF.h>
#import "KIFUITestActor+ScreenComparer.h"

@interface UITests : KIFTestCase

@end

@implementation UITests

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

- (void)testExample {
  [tester waitForViewWithAccessibilityLabel:@"userTextField"];
  [tester compareCurrentScreenWithReferenceImageNamed:@"HomeScreen@2x" withMaskNamed:@"HomeScreen_mask@2x"];
  [tester tapViewWithAccessibilityLabel:@"userTextField"];
  [tester waitForKeyboard];
  [tester compareCurrentScreenWithReferenceImageNamed:@"HomeScreen_keyboardVisible@2x" withMaskNamed:@"HomeScreen_keyboardVisible_mask@2x"];
  [tester enterTextIntoCurrentFirstResponder:@"test user\n"];
  [tester enterTextIntoCurrentFirstResponder:@"test password\n"];
  [tester waitForAbsenceOfKeyboard];
  [tester compareCurrentScreenWithReferenceImageNamed:@"HomeScreen@2x" withMaskNamed:@"HomeScreen_mask@2x"];
}

@end
