//
//  NSURLRequest+GGNetworkingMethods.m
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/28.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "NSURLRequest+GGNetworkingMethods.h"
#import <objc/runtime.h>

static void *GGNetworkingRequestParams;
@implementation NSURLRequest (GGNetworkingMethods)
- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, &GGNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, &GGNetworkingRequestParams);
}

@end
