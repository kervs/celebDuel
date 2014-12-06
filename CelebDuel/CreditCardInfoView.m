//
//  CreditCardInfoView.m
//  AddFunds
//
//  Created by JESSE SCHNEIDER on 11/30/14.
//  Copyright (c) 2014 JESSE SCHNEIDER. All rights reserved.
//

#import "CreditCardInfoView.h"

@interface CreditCardInfoView ()

@end

@implementation CreditCardInfoView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//Cancel Button
- (IBAction)cancelButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
