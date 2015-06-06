//
//  PSMyQuestionCategoryViewController.m
//  Q You
//
//  Created by Prasanna Santhappan on 3/7/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import "PSMyQuestionCategoryViewController.h"
#import "PSAskQuestionViewController.h"
#import "PSPlayAskQuestionViewController.h"
#import "PSBuyAskQuestionViewController.h"

@interface PSMyQuestionCategoryViewController ()

@end

@implementation PSMyQuestionCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"questionCategoryEatToAskQuestionSegue"]){
        PSAskQuestionViewController *askQuestionVC = segue.destinationViewController;
        askQuestionVC.selectedUser = _selectedUser;
    }
    
    if ([[segue identifier] isEqualToString:@"questionCategoryPlayToAskQuestionSegue"]){
        PSPlayAskQuestionViewController *playQuestionVC = segue.destinationViewController;
        playQuestionVC.selectedUser = _selectedUser;
    }

    if ([[segue identifier] isEqualToString:@"questionCategoryBuyToAskQuestionSegue"]){
        PSBuyAskQuestionViewController *buyQuestionVC = segue.destinationViewController;
        buyQuestionVC.selectedUser = _selectedUser;
    }
    
    
}


- (IBAction)eatButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"questionCategoryEatToAskQuestionSegue" sender:nil];
}

- (IBAction)playButtonPressed:(UIButton *)sender {
}

- (IBAction)buyButtonPressed:(UIButton *)sender {
}
@end
