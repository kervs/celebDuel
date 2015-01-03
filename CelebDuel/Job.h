//
//  Job.h
//  CelebDuel
//
//  Created by Kervins Valcourt on 12/30/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <Parse/Parse.h>

@interface Job : PFObject<PFSubclassing>
+ (NSString *)parseClassName;
@property(retain) NSString *title;
@property(retain) NSString *paymentType;
@property(retain) NSDate *jobStartDate;
@property(retain) NSString *paymentAmount;
@property (retain) PFUser *userPosted;
@property (retain) PFUser *userAccepted;

@end
