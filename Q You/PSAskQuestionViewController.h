//
//  PSAskQuestionViewController.h
//  Q You
//
//  Created by Prasanna Santhappan on 3/7/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PSAskQuestionViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) PFUser *selectedUser;

@end
