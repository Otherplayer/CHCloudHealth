//
//  NSURLRequest+FQAHCategories.m
//  FQAHProject
//
//  Created by __无邪_ on 3/31/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "NSURLRequest+FQAHCategories.h"
#import <objc/runtime.h>

static void *GGNetworkingRequestParams;
@implementation NSURLRequest (FQAHCategories)
- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, &GGNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, &GGNetworkingRequestParams);
}

@end
