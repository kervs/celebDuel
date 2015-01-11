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
    self.emailLabel.delegate = self;
    self.emailLabel.returnKeyType = UIReturnKeyNext;
    self.passwordLabel.delegate = self;
}

- (IBAction)connectWithFB:(UIButton *)sender {
    return;
}

- (IBAction)connectWithTW:(UIButton *)sender {
    return;
}


- (IBAction)loginFired:(UIButton *)sender {    
    [PFUser logInWithUsernameInBackground:self.emailLabel.text password:self.passwordLabel.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            [self createMainView];
                                            [[UIApplication sharedApplication].keyWindow setRootViewController:self.sideMenuViewController];

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
    self.navCon = [[UINavigationController alloc]initWithRootViewController:[[MainViewController  alloc]init]];
    self.leftMenuViewController = [[LeftMenuViewController alloc] init];
    self.rightMenuViewController = [[RightMenuViewController alloc] init];
    
    self.sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:self.navCon
                                                         leftMenuViewController:self.leftMenuViewController
                                                        rightMenuViewController:self.rightMenuViewController];
    self.sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    self.sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    self.sideMenuViewController.delegate = self;
    self.sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    self.sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    self.sideMenuViewController.contentViewShadowOpacity = 0.6;
    self.sideMenuViewController.contentViewShadowRadius = 12;
    self.sideMenuViewController.contentViewShadowEnabled = YES;
    
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.emailLabel) {
        [self.passwordLabel becomeFirstResponder];
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
