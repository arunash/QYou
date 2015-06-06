//
//  PSMyQuestionCategoryViewController.h
//  Q You
//
//  Created by Prasanna Santhappan on 3/7/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PSMyQuestionCategoryViewController : UIViewController

@property (strong, nonatomic) PFUser *selectedUser;

//buttons and categories
- (IBAction)eatButtonPressed:(UIButton *)sender;
- (IBAction)playButtonPressed:(UIButton *)sender;
- (IBAction)buyButtonPressed:(UIButton *)sender;



@end
