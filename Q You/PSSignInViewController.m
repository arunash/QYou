//
//  PSSignInViewController.m
//  Q You
//
//  Created by Prasanna Santhappan on 3/7/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import "PSSignInViewController.h"

@interface PSSignInViewController ()

@end

@implementation PSSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.signUpView setBackgroundColor:[UIColor colorWithRed:224/255.0 green:228/255.0 blue:204/255.0 alpha:1.0]];
    //[self.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AppNameLogo.png"]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AppNameLogo.png"]]];
    
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) {
        [self.signUpView setBackgroundColor:[UIColor colorWithRed:224/255.0 green:228/255.0 blue:204/255.0 alpha:1.0]];
        //[self.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AppNameLogo.png"]]];
    }
}


#pragma mark - helper methods

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSLog(@"newly signedup user");
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
