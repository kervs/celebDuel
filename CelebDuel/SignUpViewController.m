//
//  SignUpViewController.m
//  CelebDuel
//
//  Created by Kervins Valcourt on 11/26/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "SignUpViewController.h"
#import "MainViewController.h"
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController () <UITextFieldDelegate>{
    BOOL checked;
}
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxButton;


@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    checked = NO;
    _nameField.delegate = self;
    _nameField.returnKeyType = UIReturnKeyNext;
    _emailField.delegate = self;
    _emailField.returnKeyType = UIReturnKeyNext;
    _usernameField.delegate = self;
    _usernameField.returnKeyType = UIReturnKeyNext;
    _passwordField.delegate = self;
    

}

- (IBAction)checkBoxFired:(UIButton *)sender {
    if (!checked) {
        [_checkBoxButton setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
        checked = YES;
    }
    
    else if (checked) {
        [_checkBoxButton setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
        checked = NO;
    }
}



- (IBAction)signUpFired:(UIButton *)sender {
    UINavigationController *navCon = [[UINavigationController alloc]initWithRootViewController:[[MainViewController  alloc]init]];
    LeftMenuViewController *leftMenuViewController = [[LeftMenuViewController alloc] init];
    RightMenuViewController *rightMenuViewController = [[RightMenuViewController alloc] init];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navCon
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:rightMenuViewController];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    //self.window.rootViewController = sideMenuViewController;

    PFUser *user = [PFUser user];
    if([_usernameField.text isEqualToString:@""]) {
        // textField is empty
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                         message: @"Username Missing"
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles: nil];
        [alert show];

    } else{
    user.username = _usernameField.text;
    }
    if([_nameField.text isEqualToString:@""]) {
        // textField is empty
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                         message: @"Full Name Missing"
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles: nil];
        [alert show];
        
    } else{
    user[@"fullName"] = _nameField.text;
    }
    
    user[@"legalAge"] = [NSNumber numberWithBool:checked];
    if([_passwordField.text isEqualToString:@""]) {
        // textField is empty
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                         message: @"Password Missing"
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles: nil];
        [alert show];
        
    } else{
    user.password = _passwordField.text;
    }
    if([_emailField.text isEqualToString:@""]) {
        // textField is empty
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                         message: @"Email Missing"
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles: nil];
        [alert show];
        
    } else{
    user.email = _emailField.text.lowercaseString;
    
    }
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            [[UIApplication sharedApplication].keyWindow setRootViewController:sideMenuViewController];
            
            [PFCloud callFunctionInBackground:@"sendWelcomeEmail"
                               withParameters:@{}
                                        block:^(NSString *result, NSError *error) {
                                            if (!error) {
                                                // result is @"Hello world!"
                                                NSLog(@"%@",result);
                                            
                                                
                                            } else {
                                                NSString *errorString = [error userInfo][@"error"];
                                                // Show the errorString somewhere and let the user try again.
                                                UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                                                                 message: [NSString stringWithFormat: @"%@",errorString]
                                                                                                delegate:self
                                                                                       cancelButtonTitle:@"Cancel"
                                                                                       otherButtonTitles: nil];
                                                [alert show];
                                                

                                                
                                            }
                                        }];
            
        } else {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                             message: [NSString stringWithFormat: @"%@",errorString]
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                                   otherButtonTitles: nil];
            [alert show];
            
            NSLog(@"%@",errorString);
            
            
        }
    }];
    

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _nameField) {
        [_emailField becomeFirstResponder];
    }
    else if (textField == _emailField) {
        [ _usernameField becomeFirstResponder];
    }
    else if (textField == _usernameField) {
        [ _passwordField becomeFirstResponder];
    }
    
    else{
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}




@end
