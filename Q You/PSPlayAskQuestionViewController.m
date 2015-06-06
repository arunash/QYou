//
//  PSPlayAskQuestionViewController.m
//  Q You
//
//  Created by Prasanna Santhappan on 4/18/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import "PSPlayAskQuestionViewController.h"

@interface PSPlayAskQuestionViewController ()

//variables

@property (strong, nonatomic) IBOutlet UITextView *myQuestionText;
@property (strong, nonatomic) IBOutlet UITextField *myQuestionLocationTextField;
@property (strong, nonatomic) IBOutlet UITextField *myQuestionTime;
@property (strong, nonatomic) IBOutlet UILabel *myQuestionCostLabel;
@property (strong, nonatomic) IBOutlet UISlider *myQuestionCostSlider;

- (IBAction)myQuestionPostButton:(UIButton *)sender;

@end

@implementation PSPlayAskQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.myQuestionTime setInputView:datePicker];
    
    self.myQuestionCostSlider.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"questionCost"];
    
    [self.myQuestionCostSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.myQuestionCostLabel.text = [NSString stringWithFormat:@"%i", (int)self.myQuestionCostSlider.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myQuestionPostButton:(UIButton *)sender {
    
    PFObject *newQuestion = [PFObject objectWithClassName:@"Question"];
    [newQuestion setObject:self.selectedUser forKey:@"QuestionOwner"];
    [newQuestion setObject:self.myQuestionText.text forKey:@"QuestionText"];
    [newQuestion setObject:self.myQuestionLocationTextField.text forKey:@"QuestionLocation"];
    [newQuestion setObject:self.myQuestionTime.text forKey:@"questionDate"];
    [newQuestion setObject:[[NSNumberFormatter new] numberFromString:self.myQuestionCostLabel.text] forKey:@"questionCost"];
    [newQuestion setObject:@"Play" forKey:@"QuestionType"];
    
    [newQuestion saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error){
            //saved successfully
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congrats!" message:@"Your Play Question is set up!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
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

#pragma mark - helper methods

-(void) valueChanged: (id) sender
{
    
    if (sender == self.myQuestionCostSlider){
        [[NSUserDefaults standardUserDefaults] setInteger:self.myQuestionCostSlider.value forKey:@"questionCost"];
        
        self.myQuestionCostLabel.text = [NSString stringWithFormat:@"%i", (int)self.myQuestionCostSlider.value];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) updateTextField: (id)sender
{
    UIDatePicker *picker = [UIDatePicker new];
    [picker setDatePickerMode:UIDatePickerModeDateAndTime];
    picker = (UIDatePicker *) self.myQuestionTime.inputView;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle]; //or noStyle...
    NSString *formattedDateString = [dateFormatter stringFromDate:picker.date];
    
    self.myQuestionTime.text = [NSString stringWithFormat:@"%@", formattedDateString];
    
}


@end
