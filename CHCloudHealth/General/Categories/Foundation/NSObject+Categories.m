//
//  NSObject+Categories.m
//  HYQuan
//
//  Created by fqah on 12/10/15.
//  Copyright © 2015 fqah. All rights reserved.
//

#import "NSObject+Categories.h"
#import <objc/runtime.h>

static char associatedObjectsKey;

@implementation NSObject (Categories)

- (id)associatedObjectForKey:(NSString*)key {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &associatedObjectsKey);
    return [dict objectForKey:key];
}
- (void)setAssociatedObject:(id)object forKey:(NSString*)key {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &associatedObjectsKey);
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &associatedObjectsKey, dict, OBJC_ASSOCIATION_RETAIN);
    }
    [dict setObject:object forKey:key];
}

@end
