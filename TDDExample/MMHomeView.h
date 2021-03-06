//
// Created by Marek Moscichowski on 17/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MMHomeView : UIView

@property (nonatomic, strong) IBOutletCollection(UIImageView) NSArray *imageViews;

@property(nonatomic, strong) IBOutlet UITextField *usernameInputField;
@property(nonatomic, strong) IBOutlet UITextField *passwordInputField;
@property(nonatomic, strong) IBOutlet NSLayoutConstraint *topMarginConstraint;
@property(nonatomic, strong) IBOutlet UIButton *confirmButton;

- (IBAction)textFieldDidEndInput:(UITextField *)textField;
@end