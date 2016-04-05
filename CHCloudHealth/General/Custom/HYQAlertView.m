//
//  HYQAlertView.m
//  HotYQ
//
//  Created by __无邪_ on 15/7/22.
//  Copyright © 2015年 hotyq. All rights reserved.
//

#import "HYQAlertView.h"
#import <objc/runtime.h>

static const char UIAlertView_key_clicked;
@implementation HYQAlertView

- (void)handlerClickedButton:(void (^)(NSInteger btnIndex))aBlock{
    self.delegate = self;
    objc_setAssociatedObject(self, &UIAlertView_key_clicked, aBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark -AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    void (^block)(NSInteger btnIndex) = objc_getAssociatedObject(self, &UIAlertView_key_clicked);
    if (block) block(buttonIndex);
}


@end
