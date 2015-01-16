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
#import <FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
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
    NSArray *permissionArray = @[@"user_about_me",@"user_interests",@"user_birthday",@"user_relationships",@"user_location", @"user_relationship_details"];
    [PFFacebookUtils logInWithPermissions:permissionArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (!error) {
                NSString *message = @"Facebook Log In was Canceled";
                [self displayAlertView:message];
            }
            else {
                
                [self displayAlertView:[error userInfo][@"error"]];
                NSLog(@"%@",error);
            }
            
        } else {
            [self createMainView];
            [[UIApplication sharedApplication].keyWindow setRootViewController:self.sideMenuViewController];
        }
    }];

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

#pragma mark - FB helper method
- (void) updateUserInformation {
    FBRequest *request = [FBRequest requestForMe];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSDictionary *userDictionary = (NSDictionary *)result;
            NSMutableDictionary *userProfile = [[NSMutableDictionary alloc]initWithCapacity:8];
            if (userDictionary[@"name"]) {
                userProfile[@"name"] = userDictionary[@"name"];
            }
            if (userDictionary[@"first_name"]) {
                userProfile[@"first_name"] = userDictionary[@"first_name"];
            }
            if (userDictionary[@"location"][@"name"]) {
                userProfile[@"location"] = userDictionary[@"location"][@"name"];
            }
            if (userDictionary[@"gender"]) {
                userProfile[@"gender"] = userDictionary[@"gender"];
            }
            if (userDictionary[@"birthday"]) {
                userProfile[@"birthday"] = userDictionary[@"birthday"];
            }
            if (userDictionary[@"interested_in"]) {
                userProfile[@"interested_in"] = userDictionary[@"interested_in"];
            }
            [[PFUser currentUser]setObject:userProfile forKey:@"profile"];
            [[PFUser currentUser]saveInBackground];
        }
        else {
            [self displayAlertView:[error description]];
        }
    }];
}


@end
