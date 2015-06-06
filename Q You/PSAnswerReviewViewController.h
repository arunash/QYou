//
//  PSAnswerReviewViewController.h
//  Q You
//
//  Created by Prasanna Santhappan on 6/6/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PSAnswerReviewViewController : UIViewController

@property (strong, nonatomic) PFUser *selectedUser;
@property (strong, nonatomic) PFObject *answerToReview;

@property (strong, nonatomic) IBOutlet UITextView *questionToAnswer;
@property (strong, nonatomic) IBOutlet UILabel *currentAnswerLabel;
@property (strong, nonatomic) IBOutlet UITextView *currentAnswerDetailTextView;
@property (strong, nonatomic) IBOutlet UILabel *currentAnswerCostLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentAnswerLocationLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentAnswerTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentAnswerAuthorLabel;



@end
