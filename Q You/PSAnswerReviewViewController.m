//
//  PSAnswerReviewViewController.m
//  Q You
//
//  Created by Prasanna Santhappan on 6/6/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import "PSAnswerReviewViewController.h"

@interface PSAnswerReviewViewController ()

@end

@implementation PSAnswerReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"current user: %@", _selectedUser);
    
    NSLog(@"current answer to review: %@", _answerToReview);
    
    [self loadViewDetails];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods

-(void)loadViewDetails
{
    self.currentAnswerLabel.text = _answerToReview[@"currentAnswer"];
    self.currentAnswerDetailTextView.text = _answerToReview[@"currentAnswerDetail"];
    //self.currentAnswerCostLabel.text = _answerToReview[@"answerCost"];
    
    //self.currentAnswerCostLabel.text = [NSString stringWithFormat:@"%@", _answerToReview[@"answerCost"]];
    
    //self.currentAnswerLocationLabel.text = _answerToReview[@"answerLocation"];
    
    self.currentAnswerTimeLabel.text = _answerToReview[@"answerTime"];
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo: [_answerToReview[@"currentUser"] objectId]];
    PFQuery *queryCombined = [PFQuery orQueryWithSubqueries:@[query]];
    [queryCombined findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error){
            
            self.currentAnswerAuthorLabel.text = objects[0][@"username"];
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"Question"];
    [query2 whereKey:@"objectId" equalTo:[_answerToReview[@"questionRef"] objectId]];
    PFQuery *queryCombined2 = [PFQuery orQueryWithSubqueries:@[query2]];
    [queryCombined2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.questionToAnswer.text = objects[0][@"QuestionText"];
    }];
    
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
