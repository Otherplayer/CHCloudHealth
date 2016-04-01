//
//  HYQHelperReachibility.h
//  HYQark
//
//  Created by __无邪_ on 15/5/5.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Internet [FQAHReachibility sharedInstance]

@interface FQAHReachibility : NSObject

@property (nonatomic, unsafe_unretained) BOOL isReachable;
@property (nonatomic, unsafe_unretained) BOOL isReachableWifi;
//@property (nonatomic, strong) NSString *wifiName;

+ (FQAHReachibility *)sharedInstance;
- (void)startMonitoringInternetStates;

@end
