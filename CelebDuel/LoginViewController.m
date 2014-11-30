//
//  LoginViewController.m
//  CelebDuel
//
//  Created by Kervins Valcourt on 11/26/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "LeftMenuViewController.h"
#import <Parse/Parse.h>
#import "RightMenuViewController.h"


@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _emailLabel.delegate = self;
    _emailLabel.returnKeyType = UIReturnKeyNext;
    _passwordLabel.delegate = self;
}

- (IBAction)loginFired:(UIButton *)sender {
    
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
   
    
    [PFUser logInWithUsernameInBackground:_emailLabel.text password:_passwordLabel.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            [[UIApplication sharedApplication].keyWindow setRootViewController:sideMenuViewController];

                                        } else {
                                            // The login failed. Check error to see why.
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


    
    
    
    
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _emailLabel) {
        [_passwordLabel becomeFirstResponder];
    }
    
    else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



@end
