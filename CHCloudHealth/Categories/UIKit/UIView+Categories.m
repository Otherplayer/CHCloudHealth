//
//  UIView+Categories.m
//  HYQuan
//
//  Created by fqah on 12/10/15.
//  Copyright © 2015 fqah. All rights reserved.
//

#import "UIView+Categories.h"
#import <objc/runtime.h>

#undef   KEY_TAGSTRING
#define  KEY_TAGSTRING     "UIView.tagString"

@implementation UIView (Categories)

- (NSString *)tagString {
    NSObject *obj = objc_getAssociatedObject(self, KEY_TAGSTRING);
    if (obj && [obj isKindOfClass:[NSString class]]) {
        return (NSString *)obj;
    }
    return nil;
}

- (void)setTagString:(NSString *)value {
    objc_setAssociatedObject(self, KEY_TAGSTRING, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)viewWithTagString:(NSString *)value {
    if (nil == value) {
        return nil;
    }
    
    for (UIView *subview in self.subviews) {
        NSString *tag = subview.tagString;
        if ([tag isEqualToString:value])
        {
            return subview;
        }
    }
    
    return nil;
}



- (void)addCornerRadius:(CGFloat)radius{
    //    [self.layer setCornerRadius:radius];
    //    [self.layer setMasksToBounds:YES];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
- (void)addCornerTopRadius:(CGFloat)radius{
    //    [self.layer setCornerRadius:radius];
    //    [self.layer setMasksToBounds:YES];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)addCornerRadius:(CGFloat)radius tradition:(BOOL)flag{
    if (flag) {
        [self.layer setCornerRadius:radius];
        [self.layer setMasksToBounds:YES];
    }else{
        [self addCornerRadius:radius];
    }
}

- (void)addCornerExceptLeftTopRadius:(CGFloat)radius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopRight  cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
}

-(void)addCornerExceptLeftTopBottomRadius:(CGFloat)radius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:  UIRectCornerBottomRight | UIRectCornerTopRight  cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;

}
-(void)addCornerExceptRightTopBottomRadius:(CGFloat)radius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:  UIRectCornerBottomLeft | UIRectCornerTopLeft  cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    
}
-(void)addCornerExceptBottomRadius:(CGFloat)radius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:  UIRectCornerTopRight | UIRectCornerTopLeft  cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    
}




@end
