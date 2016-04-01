//
//  UIApplication+Categories.m
//  HotYQ
//
//  Created by __无邪_ on 15/11/5.
//  Copyright © 2015年 hotyq. All rights reserved.
//

#import "UIApplication+Categories.h"

@implementation UIApplication (Categories)


+ (BOOL)hideKeyboard{
    return [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
