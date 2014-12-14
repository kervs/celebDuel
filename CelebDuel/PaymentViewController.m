//
//  PaymentViewController.m
//  
//
//  Created by Kervins Valcourt on 12/13/14.
//
//

#import "PaymentViewController.h"
#import "PTKView.h"
#import "Stripe.h"
#import <Parse/Parse.h>

@interface PaymentViewController ()<PTKViewDelegate>
@property(weak, nonatomic) PTKView *paymentView;
@property(strong,nonatomic) UIBarButtonItem *saveButton;
@property(strong,nonatomic)STPCard * card;

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonFired:)];
    self.saveButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = self.saveButton;
    
    PTKView *view = [[PTKView alloc] initWithFrame:CGRectMake(15,70,290,55)];
    self.paymentView = view;
    self.paymentView.delegate = self;
    [self.view addSubview:self.paymentView];
}

- (void)paymentView:(PTKView *)view withCard:(PTKCard *)card isValid:(BOOL)valid
{
    // Toggle navigation, for example
    NSLog(@"Card number: %@", card.number);
    NSLog(@"Card expiry: %lu/%lu", (unsigned long)card.expMonth, (unsigned long)card.expYear);
    NSLog(@"Card cvc: %@", card.cvc);
    NSLog(@"Address zip: %@", card.addressZip);
    self.card = [[STPCard alloc] init];
    self.card.number = card.number;
    self.card.expMonth = card.expMonth;
    self.card.expYear = card.expYear;
    self.card.cvc = card.cvc;
    self.saveButton.enabled = valid;
}

- (void)saveButtonFired:(id)sender {
    [Stripe createTokenWithCard:_card completion:^(STPToken *token, NSError *error) {
        if (error) {
            [self handleError:error];
        } else {
            NSLog(@"got token");
            NSNumber *cost = [NSNumber numberWithInt:123443];
            NSMutableDictionary *newDic =[[NSMutableDictionary alloc]init];
            [newDic setObject:token.tokenId forKey:@"token"];
            [newDic setObject:cost forKey:@"amount"];
            [PFCloud callFunctionInBackground:@"chargeCard"
                               withParameters:newDic
                                        block:^(id object, NSError *error) {
                                            
                                            if(error)
                                            {
                                                [self handleError:error];
                                            }
                                            else {
                                                
                                                NSLog(@"it works");
                                            }
                                        }];
            
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) handleError:(NSError *)error {
    NSString *errorString = [error userInfo][@"error"];
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                     message: errorString
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles: nil];
    [alert show];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
