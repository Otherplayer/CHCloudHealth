//
//  NSObject+GGNetworkingMethods.m
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/28.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "NSObject+GGNetworkingMethods.h"

@implementation NSObject (GGNetworkingMethods)
- (id)defaultValue:(id)defaultData
{
    if (![defaultData isKindOfClass:[self class]]) {
        return defaultData;
    }
    
    if ([self isEmptyObject]) {
        return defaultData;
    }
    
    return self;
}

- (BOOL)isEmptyObject
{
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([(NSDictionary *)self count] == 0) {
            return YES;
        }
    }
    
    return NO;
}
@end
