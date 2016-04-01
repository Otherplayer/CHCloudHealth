//
//  UIControl+Categories.m
//  GGClickButton
//
//  Created by __无邪_ on 15/9/11.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "UIControl+Categories.h"
#import <objc/runtime.h>


static const char *UIControl_acceptEventInterval = "UIControl_Button_acceptEventInterval";
static const char *UIControl_uxy_ignoreEvent     = "UIControl_Button_uxy_ignoreEvent";

@interface UIControl ()
@property (nonatomic,assign) BOOL uxy_ignoreEvent;
@end

@implementation UIControl (Categories)

#pragma mark - life

+ (void)load{
    
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(__uxy_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
}


- (void)__uxy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (self.uxy_ignoreEvent) return;
    
    if (self.uxy_acceptEventInterval > 0){
        self.uxy_ignoreEvent = YES;
        [self performSelector:@selector(setUxy_ignoreEvent:) withObject:@(NO) afterDelay:self.uxy_acceptEventInterval];
    }
    
    [self __uxy_sendAction:action to:target forEvent:event];
}



#pragma mark - setter & getter

- (NSTimeInterval)uxy_acceptEventInterval{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setUxy_acceptEventInterval:(NSTimeInterval)uxy_acceptEventInterval{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(uxy_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(BOOL)uxy_ignoreEvent{
    return [objc_getAssociatedObject(self, UIControl_uxy_ignoreEvent) boolValue];
}

-(void)setUxy_ignoreEvent:(BOOL)uxy_ignoreEvent{
    objc_setAssociatedObject(self, UIControl_uxy_ignoreEvent, @(uxy_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
