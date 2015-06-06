//
//  PSAnswerStartViewController.h
//  Q You
//
//  Created by Prasanna Santhappan on 3/7/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PSAnswerStartViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) PFObject *questionToAnswer;
@property (strong, nonatomic) PFUser *selectedUser;


@property (strong, nonatomic) IBOutlet UIImageView *questionUserImage;
@property (strong, nonatomic) IBOutlet UILabel *questionUserName;
@property (strong, nonatomic) IBOutlet UILabel *questionUserLocation;
@property (strong, nonatomic) IBOutlet UITextView *questionAsked;

@property (strong, nonatomic) IBOutlet UILabel *questionTimerCount;


- (IBAction)answerQuestionButton:(UIButton *)sender;

//tableview
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
