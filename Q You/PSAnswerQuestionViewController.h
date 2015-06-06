//
//  PSAnswerQuestionViewController.h
//  Q You
//
//  Created by Prasanna Santhappan on 5/30/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PSAnswerQuestionViewController : UIViewController

@property (strong, nonatomic) PFObject *questionToAnswer;
@property (strong, nonatomic) PFUser *selectedUser;


@end
