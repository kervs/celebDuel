//
//  CreditCardInfoView.m
//  AddFunds
//
//  Created by JESSE SCHNEIDER on 11/30/14.
//  Copyright (c) 2014 JESSE SCHNEIDER. All rights reserved.
//

#import "CreditCardInfoView.h"

@interface CreditCardInfoView () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UITextField *cardNumber;
@property (strong, nonatomic) IBOutlet UITextField *expMonth;
@property (strong, nonatomic) IBOutlet UITextField *expYear;
@property (strong, nonatomic) IBOutlet UITextField *securityCode;
@property (strong, nonatomic) IBOutlet UITextField *billingInfoName;
@property (weak, nonatomic) IBOutlet UITextField *billingInfoState;
@property (strong,nonatomic) NSArray *theStates;
@property (strong, nonatomic) IBOutlet UITextField *billingInfoZipCode;

- (IBAction)scanCreditCard:(id)sender;

@end

@implementation CreditCardInfoView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    [self.cardNumber setDelegate:self];
    _cardNumber.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.expMonth setDelegate:self];
    _expMonth.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.expYear setDelegate:self];
    _expYear.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.securityCode setDelegate:self];
    _securityCode.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.billingInfoName setDelegate:self];
    _billingInfoName.keyboardType = UIKeyboardTypeAlphabet;
    
    [self.billingInfoZipCode setDelegate:self];
    _billingInfoZipCode.keyboardType = UIKeyboardTypeNumberPad;
    
    // Initialize Data
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate = self;
    self.billingInfoState.inputView = picker;
    self.theStates = @[@"Alabama", @"Alaska", @"American Samoa", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"District of Columbia", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Puerto Rico", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virgin Islands", @"Virgina", @"Washington", @"West Virgina", @"Wisconsin",@"Wyoming",];
}

//Cancel Button
- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.cardNumber isFirstResponder] && [touch view] != self.cardNumber) {
        [self.cardNumber resignFirstResponder];
    }
    if ([self.expMonth isFirstResponder] && [touch view] != self.expMonth) {
        [self.expMonth resignFirstResponder];
    }
    if ([self.expYear isFirstResponder] && [touch view] != self.expYear) {
        [self.expYear resignFirstResponder];
    }
    if ([self.securityCode isFirstResponder] && [touch view] != self.securityCode) {
        [self.securityCode resignFirstResponder];
    }
    if ([self.billingInfoName isFirstResponder] && [touch view] != self.billingInfoName) {
        [self.billingInfoName resignFirstResponder];
    }
    if ([self.billingInfoState isFirstResponder] && [touch view] != self.billingInfoState) {
        [self.billingInfoState resignFirstResponder];
    }
    if ([self.billingInfoZipCode isFirstResponder] && [touch view] != self.billingInfoZipCode) {
        [self.billingInfoZipCode resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
    
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
    self.billingInfoState.text = self.theStates[row];
    [self.billingInfoState resignFirstResponder];
}

- (IBAction)depositFunds:(id)sender {

    //DO SERVER CALL HERE!

    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)scanCreditCard:(id)sender {

   //SCAN CREDIT CARD STUFF HERE?
    
}


@end
