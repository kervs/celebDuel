//
//  AddFunds.h
//  AddFunds
//
//  Created by JESSE SCHNEIDER on 11/28/14.
//  Copyright (c) 2014 JESSE SCHNEIDER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditCardInfoView.h"

@interface AddFunds : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *statesTextField;

@property (strong,nonatomic) NSArray *theStates;

@property (strong, nonatomic) IBOutlet UITextField *depositAmountTextField;

- (IBAction)creditCard:(id)sender;


@end
