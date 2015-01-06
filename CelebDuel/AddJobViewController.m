//
//  AddJobViewController.m
//  CelebDuel
//
//  Created by Kervins Valcourt on 1/4/15.
//  Copyright (c) 2015 EastoftheWestEnd. All rights reserved.
//

#import "AddJobViewController.h"
#import "Job.h"

@interface AddJobViewController ()
@property (strong, nonatomic) IBOutlet UITextField *jobTitleTextField;
@property (strong, nonatomic) IBOutlet UITextField *jobCompensationTextField;
@property (strong, nonatomic) IBOutlet UITextField *jobFormOfPaymentTextField;
@property (strong, nonatomic) IBOutlet UITextView *jobDescriptionTextView;
@property (strong, nonatomic) IBOutlet UITextField *jobZipCodeTextField;

@end

@implementation AddJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _jobTitleTextField.delegate = self;
    _jobCompensationTextField.delegate = self;
    _jobFormOfPaymentTextField.delegate = self;
    _jobZipCodeTextField.delegate = self;
    _jobTitleTextField.returnKeyType = UIReturnKeyNext;
    _jobCompensationTextField.returnKeyType = UIReturnKeyNext;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelBtnDidPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)jobPostBtnDidPreesed:(UIButton *)sender {
    if ([self checkFieldsComplete]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
        return;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _jobTitleTextField) {
        [ _jobCompensationTextField becomeFirstResponder];
    } else if(textField == _jobCompensationTextField){
        [_jobFormOfPaymentTextField becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL) checkFieldsComplete {
    //check user has completed all fields
    if ([_jobTitleTextField.text isEqualToString:@""] || [_jobCompensationTextField.text isEqualToString:@""]|| [_jobFormOfPaymentTextField.text isEqualToString:@""] || [_jobZipCodeTextField.text isEqualToString:@""]) {
        NSString *message = @"You need to complete all fields";
        [self displayAlertView:message];
        return NO;
    }
    else {
        [self createNewJob];
        return YES;
    }
}

- (void)createNewJob {
    Job *newJob = [Job object];
    newJob.title = _jobTitleTextField.text;
    newJob.paymentAmount = _jobCompensationTextField.text;
    newJob.paymentAmount = _jobCompensationTextField.text;
    newJob.userPosted = [PFUser currentUser];
    [newJob saveInBackground];
    
}

- (void)displayAlertView:(NSString *)message{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                     message: message
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles: nil];
    [alert show];
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
