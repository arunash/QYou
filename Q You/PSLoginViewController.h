//
//  PSLoginViewController.h
//  Q You
//
//  Created by Prasanna Santhappan on 3/7/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "PFSignUpViewController.h"
#import "PFLogInViewController.h"


@interface PSLoginViewController : PFLogInViewController <PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;

@end
