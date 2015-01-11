//
//  MoneyEarnedViewController.m
//  CelebDuel
//
//  Created by Kervins Valcourt on 1/6/15.
//  Copyright (c) 2015 EastoftheWestEnd. All rights reserved.
//

#import "MoneyEarnedViewController.h"
#import <Parse/Parse.h>

@interface MoneyEarnedViewController ()
@property (strong, nonatomic) IBOutlet UILabel *userCurrentBalance;
@property (strong, nonatomic) IBOutlet UITextField *amountToBeWithdrawn;

@end

@implementation MoneyEarnedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)payPalBtnDidPressed:(id)sender {
    if ([self checkFieldsComplete]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
        return;
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
     return YES;
}
- (IBAction)cancelBtnDidPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL) checkFieldsComplete {
    //check user has completed all fields
    if ([self.amountToBeWithdrawn.text isEqualToString:@""]){
        NSString *message = @"You need to complete all fields";
        [self displayAlertView:message];
        return NO;
        
    } else {
        [self sendAmountToPayPal];
        return YES;
    }
}

- (void)sendAmountToPayPal{
    
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:self.amountToBeWithdrawn.text];
    NSMutableDictionary *newDic =[[NSMutableDictionary alloc]init];
    [newDic setObject:[PFUser currentUser].objectId forKey:@"userId"];
    [newDic setObject:amount forKey:@"amount"];
    [PFCloud callFunctionInBackground:@"sendPayout"
                       withParameters:newDic
                                block:^(id object, NSError *error) {
                                    
                                    if(error)
                                    {
                                        [self displayAlertView:[error userInfo][@"error"]];
                                    }
                                    else {
                                        
                                        NSLog(@"it works");
                                    }
                                }];

    
}
- (void)displayAlertView:(NSString *)message{
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                         message: message
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles: nil];
        [alert show];
    }

@end
