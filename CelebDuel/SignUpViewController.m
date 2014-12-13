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
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *checkBoxButton;
@property (strong,nonatomic) UINavigationController *navCon;
@property (strong,nonatomic) LeftMenuViewController *leftMenuViewController;
@property (strong,nonatomic) RightMenuViewController *rightMenuViewController;
@property (strong,nonatomic) RESideMenu *sideMenuViewController;

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
    PFUser *user = [PFUser user];
    user.username = self.usernameField.text;
    user.password = self.passwordField.text;
    
    if ([self.passwordField.text isEqualToString:@""]) {
        [self displayAlertView:@"Missing Password"];
        return;
    } else if(self.passwordField.text.length <= 6)
    {
        [self displayAlertView:@"Needs to be aleast 6 characters"];
        return;
    } else if(![self.passwordField.text isEqualToString:@""] && self.passwordField.text.length >= 6 ) {
        user.password = self.passwordField.text;
    }
    user.email = self.emailField.text;
    user[@"legalAge"] = [NSNumber numberWithBool:checked];
    user[@"fullName"] = _nameField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            [self createMainView];
            [[UIApplication sharedApplication].keyWindow setRootViewController:_sideMenuViewController];
            
            [PFCloud callFunctionInBackground:@"sendWelcomeEmail"
                               withParameters:@{}
                                        block:^(NSString *result, NSError *error) {
                                            if (!error) {
                                                NSLog(@"%@",result);
                                                
                                            } else {
                                                NSString *errorString = [error userInfo][@"error"];
                                                // Show the errorString somewhere and let the user try again.
                                                [self displayAlertView:[NSString stringWithFormat: @"%@",errorString]];
                                                
                                            }
                                        }];
            
        } else {
            NSString *errorString = [error userInfo][@"error"];
            [self displayAlertView:[NSString stringWithFormat: @"%@",errorString]];
            
            
        }
    }];
    

}

- (void)createMainView {
    _navCon = [[UINavigationController alloc]initWithRootViewController:[[MainViewController  alloc]init]];
    _leftMenuViewController = [[LeftMenuViewController alloc] init];
    _rightMenuViewController = [[RightMenuViewController alloc] init];
    
    _sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:_navCon
                                                                    leftMenuViewController:_leftMenuViewController
                                                                   rightMenuViewController:_rightMenuViewController];
    _sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    _sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    _sideMenuViewController.delegate = self;
    _sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    _sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    _sideMenuViewController.contentViewShadowOpacity = 0.6;
    _sideMenuViewController.contentViewShadowRadius = 12;
    _sideMenuViewController.contentViewShadowEnabled = YES;

    
}

- (void)displayAlertView:(NSString *)message{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                     message: message
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles: nil];
    [alert show];
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
