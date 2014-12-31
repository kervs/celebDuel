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
@property (strong,nonatomic) UINavigationController *navCon;
@property (strong,nonatomic) LeftMenuViewController *leftMenuViewController;
@property (strong,nonatomic) RightMenuViewController *rightMenuViewController;
@property (strong,nonatomic) RESideMenu *sideMenuViewController;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _emailLabel.delegate = self;
    _emailLabel.returnKeyType = UIReturnKeyNext;
    _passwordLabel.delegate = self;
}

- (IBAction)connectWithFB:(UIButton *)sender {
    return;
}

- (IBAction)connectWithTW:(UIButton *)sender {
    return;
}


- (IBAction)loginFired:(UIButton *)sender {    
    [PFUser logInWithUsernameInBackground:_emailLabel.text password:_passwordLabel.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            [self createMainView];
                                            [[UIApplication sharedApplication].keyWindow setRootViewController:_sideMenuViewController];

                                        } else {
                                            // The login failed. Check error to see why.
                                            
                                            [self displayAlertView:[error description]];

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
