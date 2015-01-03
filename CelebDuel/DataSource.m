//
//  DataSource.m
//  CelebDuel
//
//  Created by Kervins Valcourt on 12/30/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "DataSource.h"
#import <Parse/Parse.h>
#import "Job.h"
@interface DataSource ()
@property (nonatomic, strong)NSArray *jobItems;

@end

@implementation DataSource

+(instancetype)sharedInstance{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once,^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;    
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        [self pullDataFromServer];
    }
    return self;
}

- (void)displayAlertView:(NSString *)message{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Error"
                                                     message: message
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles: nil];
    [alert show];
}

-(void)pullDataFromServer{
    NSMutableArray *_mutableJobItems = [NSMutableArray array];
    PFQuery *query = [PFQuery queryWithClassName:@"Job"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu jobs.", (unsigned long)objects.count);
            // Do something with the found objects
            for (Job *object in objects) {
                [_mutableJobItems addObject:object];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [self displayAlertView:[NSString stringWithFormat: @"%@",[error userInfo]]];
            
        }
        self.jobItems = _mutableJobItems;
    }];

    
}


@end
