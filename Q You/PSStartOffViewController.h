//
//  PSStartOffViewController.h
//  Q You
//
//  Created by Prasanna Santhappan on 3/7/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>

#import "PFLogInViewController.h"
#import "PFSignUpViewController.h"

@interface PSStartOffViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>

//Buttons
- (IBAction)whatButtonPressed:(UIButton *)sender;
- (IBAction)logOutButtonPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) NSMutableArray *mainQuestionsArray;

//Table View
@property (strong, nonatomic) IBOutlet UITableView *tableView;



@end
