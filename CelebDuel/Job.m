//
//  Job.m
//  CelebDuel
//
//  Created by Kervins Valcourt on 12/30/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "Job.h"

@implementation Job

@dynamic title;
@dynamic paymentType;
@dynamic jobStartDate;
@dynamic paymentAmount;
@dynamic userPosted;
@dynamic userAccepted;
+ (NSString *)parseClassName {
    return @"Job";
}

@end
