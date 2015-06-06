//
//  PSAnswerDetailsViewController.h
//  Q You
//
//  Created by Prasanna Santhappan on 3/7/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PSAnswerDetailsViewController : UIViewController


@property (strong, nonatomic) PFUser *selectedUser;
@property (strong, nonatomic) PFObject *questionToAnswer;

@property (strong, nonatomic) IBOutlet UILabel *answerUserNameLabel;

@property (strong, nonatomic) IBOutlet UITextField *answerNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *answerDetailTextView;
@property (strong, nonatomic) IBOutlet UISlider *answerCostSlider;
@property (strong, nonatomic) IBOutlet UILabel *answerCostLabel;
@property (strong, nonatomic) IBOutlet UITextField *answerTimeTextField;
@property (strong, nonatomic) IBOutlet UILabel *askedQuestionLabel;

//Actions

- (IBAction)postMyAnswerButton:(UIButton *)sender;

@end
