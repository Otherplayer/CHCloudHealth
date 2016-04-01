//
//  UIColor+Gradient.h
//  IOS-Categories
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Gradient)
//渐变左右方向
+ (UIColor*)gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;

// 自上而下
+ (UIColor*)gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 height:(int)height;

+ (UIColor *)navcColor;
+ (UIColor *)textPlaceHolderColor;

+ (UIColor *)color_f7f8f8;

+ (UIColor *)color_4d4d4d;

+ (UIColor *)color_f2f2f2;
+ (UIColor *)color_666666;
+ (UIColor *)color_FFB400;

+ (UIColor *)color_cccccc;

+ (UIColor *)color_e6e6e6;

+ (UIColor *)color_ff7bac;

+ (UIColor *)color_ff8e00;

+ (UIColor *)color_b3b3b3;
+ (UIColor *)color_B3B3B3;

+ (UIColor *)color_ffb400;

+ (UIColor *)color_66666;

+ (UIColor *)color_b3bfff;

+ (UIColor *)color_b3bfff;

+ (UIColor *)color_3d5499;

+ (UIColor *)color_999999;

+ (UIColor *)color_333333;

+ (UIColor *)color_ffffff;

+ (UIColor *)color_C1272D;

+ (UIColor *)color_000000;

+ (UIColor *)color_808080;

+ (UIColor *)color_78b4ff;

+ (UIColor *)color_22b573;

+ (UIColor *)color_ff9999;

+ (UIColor *)color_f8f8f8;

+ (UIColor *)color_coedd9;

+ (UIColor *)color_c8c8c8;

+ (UIColor *)color_ffb440;

+ (UIColor *)color_3fa9f5;


+ (UIColor *)color_placeholder;

+ (UIColor *)defaultBlueColor;

+ (UIColor *)defaultRedColor;

+ (UIColor *)disabledColor;

+ (UIColor *)color_ff372d;

+ (UIColor *)color_f3372d;

@end
