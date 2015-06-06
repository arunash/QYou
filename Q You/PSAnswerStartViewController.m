//
//  PSAnswerStartViewController.m
//  Q You
//
//  Created by Prasanna Santhappan on 3/7/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import "PSAnswerStartViewController.h"
#import "PSAnswerDetailsViewController.h"
#import "PSAnswerReviewViewController.h"

@interface PSAnswerStartViewController ()

@property (strong, nonatomic) NSMutableArray *userNameArray;
@property (strong, nonatomic) NSMutableArray *mainResponseArray;
@property (strong, nonatomic) PFObject *currentAnswerToReview;

@end

@implementation PSAnswerStartViewController

-(NSMutableArray *)userNameArray
{
    if (!_userNameArray){
        _userNameArray = [[NSMutableArray alloc] init];
    }
    return _userNameArray;
}


-(NSMutableArray *)mainResponseArray
{
    if (!_mainResponseArray){
        _mainResponseArray = [[NSMutableArray alloc] init];
    }
    return _mainResponseArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"the question to answer is: %@", _questionToAnswer);
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self loadResponses];
    [self updateView];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - helper methods

-(void) updateView {
    
    self.questionUserLocation.text = _questionToAnswer[@"QuestionLocation"];
    self.questionAsked.text = _questionToAnswer[@"QuestionText"];
    
    //code to update Name field
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo: [_questionToAnswer[@"QuestionOwner"] objectId]];
    PFQuery *queryCombined = [PFQuery orQueryWithSubqueries:@[query]];
    [queryCombined findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error){
            [self.userNameArray removeAllObjects];
            self.userNameArray = [objects mutableCopy];
            self.questionUserName.text = _userNameArray[0][@"username"];
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    
    
}


-(void) loadResponses {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Answer"];
    [query whereKey:@"questionRef" equalTo:_questionToAnswer];
    PFQuery *queryCombined = [PFQuery orQueryWithSubqueries:@[query]];
    [queryCombined findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error){
            
            [self.mainResponseArray removeAllObjects];
            self.mainResponseArray = [objects mutableCopy];
            [self.tableView reloadData];
            
        }
        else {
            NSLog(@"%@",error);
        }
    }];
}

#pragma mark - tableView Methods

-(NSInteger) numberOfSectionInTableView:(UITableView *) tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%i", [self.mainQuestionsArray count]);
    return [self.mainResponseArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFObject *questionObject = self.mainResponseArray[indexPath.row];
    cell.textLabel.text = questionObject[@"currentAnswer"];
    _currentAnswerToReview = questionObject;
    //NSLog(@"the text label is: %@", cell.textLabel.text);
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"AnswerStartToAnswerReviewSegue" sender:indexPath];
    //NSLog(@"inside DSRIP");
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"AnswerStartToAnswerDetailsSegue"]){
        PSAnswerDetailsViewController *answerDetailVC = segue.destinationViewController;
        answerDetailVC.selectedUser = _selectedUser;
        answerDetailVC.questionToAnswer = _questionToAnswer;
    }
    
    if([segue.identifier isEqualToString:@"AnswerStartToAnswerReviewSegue"]){
        PSAnswerReviewViewController *answerReviewVC = segue.destinationViewController;
        
        //NSIndexPath *indexPath = sender;
        answerReviewVC.selectedUser = _selectedUser;
        answerReviewVC.answerToReview = _currentAnswerToReview;
        
    }
}


- (IBAction)answerQuestionButton:(UIButton *)sender {
}
@end
