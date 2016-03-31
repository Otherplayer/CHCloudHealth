//
//  GGLogger.h
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGURLResponse.h"

@interface GGLogger : NSObject

+ (void)logDebugResponse:(GGURLResponse *)response;

+ (void)logDebugOperation:(AFHTTPRequestOperation *)operation;

@end
