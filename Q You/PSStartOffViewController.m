//
//  PSStartOffViewController.m
//  Q You
//
//  Created by Prasanna Santhappan on 3/7/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import "PSStartOffViewController.h"
#import "PSLoginViewController.h"
#import "PSSignInViewController.h"
#import "PSMyQuestionCategoryViewController.h"
#import "PSAnswerStartViewController.h"


@interface PSStartOffViewController ()


@property (strong, nonatomic) PFObject *selectedQuestionToAnswer;

@end

@implementation PSStartOffViewController


-(NSMutableArray *)mainQuestionsArray
{
    if (!_mainQuestionsArray){
        _mainQuestionsArray = [[NSMutableArray alloc] init];
    }
    return _mainQuestionsArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self loadQuestions];
    //Checks if the user is logged in...
 
    if ([PFUser currentUser]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Awesome Your Logged In!" message:nil delegate:self cancelButtonTitle:@"Log Out" otherButtonTitles:@"Continue", nil];
        [alert show];
    }
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]){
        
        PSLoginViewController *login = [[PSLoginViewController alloc] init];
        
        login.delegate = self;
        login.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsFacebook | PFLogInFieldsSignUpButton | PFLogInFieldsPasswordForgotten;
        
        PSSignInViewController *signUpViewController = [[PSSignInViewController alloc] init];
        signUpViewController.delegate = self;
        signUpViewController.fields = PFSignUpFieldsDefault;
        
        login.signUpController = signUpViewController;
        [self presentViewController:login animated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Login Delegate Methods

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - helper methods

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [PFUser logOut];
    }
}

-(void) loadQuestions{
    
    //NSLog(@"inside loadQ");
    PFQuery *query = [PFQuery queryWithClassName:@"Question"];
    PFQuery *queryCombined = [PFQuery orQueryWithSubqueries:@[query]];
    //[query whereKey:@"QuestionType" equalTo:@"Eat"];
    [queryCombined findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            [self.mainQuestionsArray removeAllObjects];
            self.mainQuestionsArray = [objects mutableCopy];
            [self.tableView reloadData];
            
            
//            for (id item in _mainQuestionsArray)
//            {
//                NSLog(@"%@", item);
//            }
        }
        else{
            NSLog (@"%@", error);
        }
    }];
    //NSLog(@"out of loadQ");
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%i", [self.mainQuestionsArray count]);
    return [self.mainQuestionsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFObject *questionObject = self.mainQuestionsArray [indexPath.row];
    cell.textLabel.text = questionObject[@"QuestionText"];
    _selectedQuestionToAnswer = questionObject;
    //NSLog(@"the text label is: %@", cell.textLabel.text);
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"StartToAnswerStartSegue" sender:indexPath];
    //NSLog(@"inside DSRIP");
}


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"StartToAnswerStartSegue"]){
        
        PSAnswerStartViewController *answerStartVC = segue.destinationViewController;
        
        NSIndexPath *indexPath = sender;

        //NSLog(@"indexpath is: %@", indexPath);
        //answerStartVC.questionToAnswer = [self.mainQuestionsArray objectAtIndex:indexPath.row];
        answerStartVC.questionToAnswer = _selectedQuestionToAnswer;
        //NSLog(@"%@", _selectedQuestionToAnswer);
        answerStartVC.selectedUser = [PFUser currentUser];

    
    }
    
    if ([segue.identifier isEqualToString:@"StartToMyQuestionCategorySegue"]){
        PSMyQuestionCategoryViewController *questionCategoryVC = segue.destinationViewController;
        questionCategoryVC.selectedUser = [PFUser currentUser];
    }
    
    
}

#pragma mark - Button methods


- (IBAction)whatButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"StartToMyQuestionCategorySegue" sender:nil];
}

//logout bar button - logs user out
- (IBAction)logOutButtonPressed:(UIBarButtonItem *)sender {
    
    [PFUser logOut];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your Logged out" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    [self viewDidDisappear:YES];
    
}
@end
