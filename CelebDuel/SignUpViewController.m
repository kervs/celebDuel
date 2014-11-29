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

@interface SignUpViewController () {
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
    user.username = @"carlos is super gay";
    user.password = @"carlos has a small dick";
    user.email = @"email@example.com";
    user[@"gender"] = @"m";
    user[@"birthday"] = @"june";
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            [[UIApplication sharedApplication].keyWindow setRootViewController:sideMenuViewController];
            
        } else {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            NSLog(@"%@",errorString);
        }
    }];
    
    

}

@end
