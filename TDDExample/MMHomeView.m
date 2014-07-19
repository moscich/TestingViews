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
  CGFloat lowestInputField = CGRectGetMaxY(self.confirmButton.frame);
  CGRect keyboardFrame = [keyboardNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

  self.topMarginConstraint.constant = 10 - keyboardFrame.size.height + self.bounds.size.height - lowestInputField;
  [self animateLayoutChange:[keyboardNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
}

- (void)keyboardWillDissapear:(NSNotification *)keyboardNotification {
  self.topMarginConstraint.constant = self.topConstaintBeforeKeyboardAppearance;
  [self animateLayoutChange:[keyboardNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
}

- (IBAction)textFieldDidEndInput:(UITextField *)textField {
  if(textField == self.usernameInputField)
    [self.passwordInputField becomeFirstResponder];
  else if(textField == self.passwordInputField)
    [self.passwordInputField resignFirstResponder];
}

- (void)animateLayoutChange:(double)duration {
  [UIView animateWithDuration:duration
                   animations:^{
    [self layoutIfNeeded];
  }];
}

- (void)dealloc{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end