//
//  PSAnswerDetailsViewController.m
//  Q You
//
//  Created by Prasanna Santhappan on 3/7/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import "PSAnswerDetailsViewController.h"

@interface PSAnswerDetailsViewController ()

@end

@implementation PSAnswerDetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSLog(@"question to answer is: %@", _questionToAnswer);
    
    self.answerCostSlider.value = [[NSUserDefaults standardUserDefaults]integerForKey:@"answerCost"];
    [self.answerCostSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    self.answerCostLabel.text = [NSString stringWithFormat:@"%i", (int)self.answerCostSlider.value];
    
    [self loadUserDetails];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - helper methods

-(void) valueChanged: (id) sender
{
    if (sender == self.answerCostSlider){
        [[NSUserDefaults standardUserDefaults] setInteger:self.answerCostSlider.value forKey:@"answerCost"];
        self.answerCostLabel.text = [NSString stringWithFormat:@"%i", (int)self.answerCostSlider.value];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)loadUserDetails {
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo: [_selectedUser objectId]];
    PFQuery *queryCombined = [PFQuery orQueryWithSubqueries:@[query]];
    [queryCombined findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error){
            self.answerUserNameLabel.text = objects[0][@"username"];
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    self.askedQuestionLabel.text = _questionToAnswer[@"QuestionText"];
    
    
}

- (IBAction)postMyAnswerButton:(UIButton *)sender {
    
    PFObject *newAnswer = [PFObject objectWithClassName:@"Answer"];
    [newAnswer setObject:self.selectedUser forKey:@"currentUser"];
    [newAnswer setObject:self.questionToAnswer forKey:@"questionRef"];
    [newAnswer setObject:self.answerNameTextField.text forKey:@"currentAnswer"];
    [newAnswer setObject:self.answerDetailTextView.text forKey:@"currentAnswerDetail"];
    [newAnswer setObject:[[NSNumberFormatter new] numberFromString:self.answerCostLabel.text] forKey:@"answerCost"];
    [newAnswer saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            //save successfully
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you!" message:@"Now that's an Answer!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
    }];

}
@end
