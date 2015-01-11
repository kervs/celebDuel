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
#import <FacebookSDK.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface SignUpViewController () <UITextFieldDelegate>{
    BOOL checked;
}

@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (strong,nonatomic) UINavigationController *navCon;
@property (strong,nonatomic) LeftMenuViewController *leftMenuViewController;
@property (strong,nonatomic) RightMenuViewController *rightMenuViewController;
@property (strong,nonatomic) RESideMenu *sideMenuViewController;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.emailField.delegate = self;
    self.passwordField.delegate = self;
    self.firstNameField.delegate = self;
    self.lastName.delegate = self;
    self.emailField.returnKeyType = UIReturnKeyNext;
    self.passwordField.returnKeyType = UIReturnKeyNext;
    self.firstNameField.returnKeyType = UIReturnKeyNext;

}

- (IBAction)connectWithTW:(UIButton *)sender {
    return;
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
            [self sendWelcomeEmail];
        }
    }];
}



- (IBAction)signUpFired:(UIButton *)sender {
    [ self.passwordField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.firstNameField resignFirstResponder];
    [self.lastName resignFirstResponder];
    [self checkFieldsComplete];
}

- (void) checkFieldsComplete { //check user has completed all fields
    if ([self.emailField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]|| [self.firstNameField.text isEqualToString:@""] || [self.lastName.text isEqualToString:@""]) {
        NSString *message = @"You need to complete all fields";
        [self displayAlertView:message];
    }
    else {
        [self registerNewUser];
    }
}


- (void) registerNewUser {
    NSLog(@"registering....");
    PFUser *newUser = [PFUser user];
    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    newUser.username = self.emailField.text;
    NSString *fullName = [NSString stringWithFormat:@"%@ %@",self.firstNameField.text,self.lastName.text];
    newUser[@"fullName"]= fullName;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Registration success!");
            [self createMainView];
            [[UIApplication sharedApplication].keyWindow setRootViewController:self.sideMenuViewController];
            [self sendWelcomeEmail];

            }
        else {
             [self displayAlertView:[error description]];
        }
    }];
}

- (void)sendWelcomeEmail{
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
  if (textField == self.emailField) {
        [ self.passwordField becomeFirstResponder];
    } else if(textField == self.emailField){
        [self.firstNameField becomeFirstResponder];
    } else if(textField == self.firstNameField){
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
