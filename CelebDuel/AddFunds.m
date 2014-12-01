//
//  AddFunds.m
//  AddFunds
//
//  Created by JESSE SCHNEIDER on 11/28/14.
//  Copyright (c) 2014 JESSE SCHNEIDER. All rights reserved.
//

#import "AddFunds.h"


@interface AddFunds ()

@end

@implementation AddFunds

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.depositAmountTextField setDelegate:self];
    _depositAmountTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    // Initialize Data
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate = self;
    self.statesTextField.inputView = picker;
    self.theStates = @[@"Alabama", @"Alaska", @"American Samoa", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"District of Columbia", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Puerto Rico", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virgin Islands", @"Virgina", @"Washington", @"West Virgina", @"Wisconsin",@"Wyoming",];
}

//Cancel Button
- (IBAction)cancelDidFired:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.depositAmountTextField isFirstResponder] && [touch view] != self.depositAmountTextField) {
        [self.depositAmountTextField resignFirstResponder];
    }
    if ([self.statesTextField isFirstResponder] && [touch view] != self.statesTextField) {
        [self.statesTextField resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.theStates.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.theStates[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.statesTextField.text = self.theStates[row];
    [self.statesTextField resignFirstResponder];
}


- (IBAction)creditCard:(id)sender {
    CreditCardInfoView *newView = [[CreditCardInfoView alloc]init];
    
    [self presentViewController:newView animated:YES completion:nil];
    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"What do you want to do with the file?"
//                                                             delegate:self
//                                                    cancelButtonTitle:@"Cancel"
//                                               destructiveButtonTitle:@"Delete it"
//                                                    otherButtonTitles:@"Copy", @"Move", @"Duplicate", nil];
//    [actionSheet showInView:self.view];
}


@end
