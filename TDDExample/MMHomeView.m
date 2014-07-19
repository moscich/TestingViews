//
// Created by Marek Moscichowski on 17/07/14.
// Copyright (c) 2014 Marek Mościchowski. All rights reserved.
//

#import "MMHomeView.h"

@interface MMHomeView ()
@property (nonatomic, assign) CGFloat topConstaintBeforeKeyboardAppearance;
@end

@implementation MMHomeView {

}

- (void)awakeFromNib {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillBeShown:)
                                               name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillDissapear:)
                                               name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillBeShown:(NSNotification *)keyboardNotification {
  self.topConstaintBeforeKeyboardAppearance = self.topMarginConstraint.constant;
  CGFloat lowestInputField = CGRectGetMaxY(self.passwordInputField.frame);
  CGRect keyboardFrame = [keyboardNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

  self.topMarginConstraint.constant = 10 - keyboardFrame.size.height + self.bounds.size.height - lowestInputField;
  [UIView animateWithDuration:[keyboardNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                   animations:^{
    [self layoutIfNeeded];
  }];
}

- (void)keyboardWillDissapear:(NSNotification *)keyboardNotification {
  self.topMarginConstraint.constant = self.topConstaintBeforeKeyboardAppearance;
}

- (void)dealloc{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end