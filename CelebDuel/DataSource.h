//
//  DataSource.h
//  CelebDuel
//
//  Created by Kervins Valcourt on 12/30/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject
+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly)NSArray *jobItems;
@end
