//
//  PSAskQuestionViewController.m
//  Q You
//
//  Created by Prasanna Santhappan on 3/7/15.
//  Copyright (c) 2015 Prasanna Santhappan. All rights reserved.
//

#import "PSAskQuestionViewController.h"

@interface PSAskQuestionViewController ()


//variables

@property (strong, nonatomic) IBOutlet UITextView *myQuestionText;
@property (strong, nonatomic) IBOutlet UITextField *myQuestionLocationTextField;
@property (strong, nonatomic) IBOutlet UISlider *myQuestionCostSlider;
@property (strong, nonatomic) IBOutlet UILabel *myQuestionCostLabel;
@property (weak, nonatomic) IBOutlet UITextField *myQuestionDateTimeTextField;

- (IBAction)myQuestionPostButton:(UIButton *)sender;


@end

@implementation PSAskQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"current user is: %@", _selectedUser);
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.myQuestionDateTimeTextField setInputView:datePicker];
    
    self.myQuestionCostSlider.value = [[NSUserDefaults standardUserDefaults] integerForKey:@"questionCost"];
    
    [self.myQuestionCostSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.myQuestionCostLabel.text = [NSString stringWithFormat:@"%i", (int)self.myQuestionCostSlider.value];
    
    //[_myQuestionLocationTextField resignFirstResponder];
    

    
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
    [newQuestion setObject:self.myQuestionDateTimeTextField.text forKey:@"questionDate"];
    [newQuestion setObject:[[NSNumberFormatter new] numberFromString:self.myQuestionCostLabel.text] forKey:@"questionCost"];
    [newQuestion setObject:@"Eat" forKey:@"QuestionType"];
    
    
    [newQuestion saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error){
            //saved successfully
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congrats!" message:@"Your Question is set up!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }];
    
}



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
    picker = (UIDatePicker *) self.myQuestionDateTimeTextField.inputView;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle]; //or noStyle...
    NSString *formattedDateString = [dateFormatter stringFromDate:picker.date];
    
    self.myQuestionDateTimeTextField.text = [NSString stringWithFormat:@"%@", formattedDateString];
    
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    NSLog(@"inside text field dismiss");
//    [_myQuestionLocationTextField resignFirstResponder];
//    return YES;
//}

//
//NSInteger stringToInt(NSString *string) {
//    return [string integerValue];
//}


//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.myQuestionLocationTextField = textField;
}

- (void)resignOnTap:(id)iSender {
    [self.myQuestionLocationTextField resignFirstResponder];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    UITouch *touch = [[event allTouches] anyObject];
//    if ([_myQuestionLocationTextField isFirstResponder] && [touch view] != _myQuestionLocationTextField) {
//        [_myQuestionLocationTextField resignFirstResponder];
//    }
//    [super touchesBegan:touches withEvent:event];
//}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesBegan:withEvent:");
//    [self.myQuestionText endEditing:YES];
//    [super touchesBegan:touches withEvent:event];
//}


@end
