//
//  PSAnswerQuestionViewController.m
//  Q You
//
//  Created by Prasanna Santhappan on 5/30/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import "PSAnswerQuestionViewController.h"

@interface PSAnswerQuestionViewController ()

@end

@implementation PSAnswerQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"the question to answer is: %@", _questionToAnswer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
