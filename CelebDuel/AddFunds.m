//
//  AddFunds.m
//  AddFunds
//
//  Created by JESSE SCHNEIDER on 11/28/14.
//  Copyright (c) 2014 JESSE SCHNEIDER. All rights reserved.
//

#import "AddFunds.h"



@interface AddFunds ()

@property (strong,nonatomic) NSArray *theStates;
@property (strong, nonatomic) IBOutlet UITextField *statesTextField;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *zipCode;
@property (strong, nonatomic) IBOutlet UITextField *depositAmountTextField;
@property IBOutlet PTKView *paymentView;
@property (strong, nonatomic) IBOutlet UILabel *enterCardLbl;
@property(strong,nonatomic)STPCard * card;

@end

@implementation AddFunds

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.depositAmountTextField setDelegate:self];
    [self.firstName setDelegate:self];
    [self.lastName setDelegate:self];
    [self.zipCode setDelegate:self];
    
    self.firstName.returnKeyType = UIReturnKeyNext;
    self.lastName.returnKeyType = UIReturnKeyNext;
    
    
    // Initialize Data
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate = self;

    self.statesTextField.inputView = picker;
    self.theStates = @[@"Alabama", @"Alaska", @"American Samoa", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"District of Columbia", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Puerto Rico", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virgin Islands", @"Virgina", @"Washington", @"West Virgina", @"Wisconsin",@"Wyoming",];
    
    self.paymentView = [[PTKView alloc] init];
    self.paymentView.delegate = self;
    [self.view addSubview:self.paymentView];
    
    self.paymentView.translatesAutoresizingMaskIntoConstraints = NO;
    
  
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.paymentView attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:20.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.paymentView attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:20.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.paymentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.enterCardLbl attribute:NSLayoutAttributeLeading multiplier:1.0f constant:20.0f]];
}

- (IBAction)canelBtnDidFired:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)paymentView:(PTKView *)view withCard:(PTKCard *)card isValid:(BOOL)valid
{
    // Toggle navigation, for example
    NSLog(@"Card number: %@", card.number);
    NSLog(@"Card expiry: %lu/%lu", (unsigned long)card.expMonth, (unsigned long)card.expYear);
    NSLog(@"Card cvc: %@", card.cvc);
    NSLog(@"Address zip: %@", card.addressZip);
    self.card = [[STPCard alloc] init];
    self.card.number = card.number;
    self.card.expMonth = card.expMonth;
    self.card.expYear = card.expYear;
    self.card.cvc = card.cvc;
}


- (IBAction)chargeCard:(id)sender {
    self.card.name = [NSString stringWithFormat:@"%@ %@",self.firstName.text,self.lastName.text];
    self.card.addressZip = self.zipCode.text;
    self.card.addressState = self.statesTextField.text;
    
    [Stripe createTokenWithCard:_card completion:^(STPToken *token, NSError *error) {
        if (error) {
            [self handleError:error];
        } else {
            NSLog(@"got token");
            NSNumber *cost = [NSNumber numberWithInt:[self.depositAmountTextField.text intValue]*100];
            NSMutableDictionary *newDic =[[NSMutableDictionary alloc]init];
            [newDic setObject:token.tokenId forKey:@"token"];
            [newDic setObject:cost forKey:@"amount"];
            [PFCloud callFunctionInBackground:@"chargeCard"
                               withParameters:newDic
                                        block:^(id object, NSError *error) {
                                            
                                            if(error)
                                            {
                                                [self handleError:error];
                                            }
                                            else {
                                                
                                                NSLog(@"it works");
                                            }
                                        }];
            
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.depositAmountTextField) {
        [ self.firstName becomeFirstResponder];
    } else if(textField == self.firstName){
        [self.lastName becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void) handleError:(NSError *)error {
    NSString *errorString = [error userInfo][@"error"];
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                     message: errorString
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles: nil];
    [alert show];
    
    
}



@end
