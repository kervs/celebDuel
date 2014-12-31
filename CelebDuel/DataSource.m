//
//  DataSource.m
//  CelebDuel
//
//  Created by Kervins Valcourt on 12/30/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

+(instancetype)sharedInstance{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once,^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
    
}



@end
