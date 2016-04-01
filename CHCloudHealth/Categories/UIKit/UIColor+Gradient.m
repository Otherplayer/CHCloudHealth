//
//  UIColor+Gradient.m
//  IOS-Categories
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIColor+Gradient.h"

@implementation UIColor (Gradient)

#pragma mark - Gradient Color

+ (UIColor*)gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height
{
    CGRect mainScreen = [[UIScreen mainScreen] bounds];
    CGSize size = CGSizeMake(CGRectGetWidth(mainScreen), 1);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(size.width, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor*)gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 height:(int)height{
    return GradientFromColor(c1, c2, height);
}

static inline UIColor *GradientFromColor(UIColor *fromColor,UIColor *toColor,int height){
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* colors = [NSArray arrayWithObjects:(id)fromColor.CGColor, (id)toColor.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}
+ (UIColor *)navcColor{
    UIColor *color = [UIColor gradientFromColor:[UIColor colorWithRed:0.953
                                                                green:0.486
                                                                 blue:0.059
                                                                alpha:1.000]
                                        toColor:[UIColor
                                                 colorWithRed:0.949
                                                 green:0.000
                                                 blue:0.322
                                                 alpha:1.000]
                                     withHeight:64];
    
    return color;
}

+ (UIColor *)textPlaceHolderColor{
    return [UIColor colorFromHexRGB:@"#b3b3b3"];
}

+ (UIColor *)color_4d4d4d{
    return [UIColor colorFromHexRGB:@"#4d4d4d"];
}

+ (UIColor *)color_f2f2f2{
    return [UIColor colorFromHexRGB:@"#f2f2f2"];
}
+ (UIColor *)color_FFB400{
    return [UIColor colorFromHexRGB:@"#FFB400"];
}

+ (UIColor *)color_cccccc{
    return [UIColor colorFromHexRGB:@"#cccccc"];
}
+ (UIColor *)color_e6e6e6{
    return [UIColor colorFromHexRGB:@"#e6e6e6"];
}
+ (UIColor *)color_666666{
    return [UIColor colorFromHexRGB:@"#666666"];
}

+ (UIColor *)color_ff7bac{
    return [UIColor colorFromHexRGB:@"#ff7bac"];
}

+ (UIColor *)color_ff8e00{
    return [UIColor colorFromHexRGB:@"#ff8e00"];
}
//黄色
+ (UIColor *)color_ffb400
{
    return [UIColor colorFromHexRGB:@"#ffb400"];
}
+ (UIColor *)color_b3b3b3{
    return [UIColor colorFromHexRGB:@"#b3b3b3"];
}

+ (UIColor *)color_B3B3B3{
    return [UIColor colorFromHexRGB:@"#B3B3B3"];
}

+ (UIColor *)color_66666{
    return [UIColor colorFromHexRGB:@"#666666"];
}

+ (UIColor *)color_b3bfff{
    return [UIColor colorFromHexRGB:@"#b3bfff"];
}
+ (UIColor *)color_ff9999{
    return [UIColor colorFromHexRGB:@"#ff9999"];
}
+ (UIColor *)color_f8f8f8{
    return [UIColor colorFromHexRGB:@"#f8f8f8"];
}

+ (UIColor *)color_3d5499{
    return [UIColor colorFromHexRGB:@"#3d5499"];
}

+ (UIColor *)color_999999{
    return [UIColor colorFromHexRGB:@"#999999"];
}

+ (UIColor *)color_333333{
    return [UIColor colorFromHexRGB:@"#333333"];
}
+ (UIColor *)color_ffffff
{
    return  [UIColor colorFromHexRGB:@"#ffffff"];
}
+ (UIColor *)color_C1272D
{
    return  [UIColor colorFromHexRGB:@"#C1272D"];
}

+ (UIColor *)color_000000
{
    return  [UIColor colorFromHexRGB:@"#000000"];
}

+ (UIColor *)color_coedd9
{
    return  [UIColor colorFromHexRGB:@"coedd9"];
}
+ (UIColor *)color_808080{
    return [UIColor colorFromHexRGB:@"#808080"];
}
+ (UIColor *)color_78b4ff{
    return [UIColor colorFromHexRGB:@"#78b4ff"];
}

+ (UIColor *)color_f7f8f8
{
 return [UIColor colorFromHexRGB:@"#f7f8f8"];
}
+ (UIColor *)color_22b573{
    return [UIColor colorFromHexRGB:@"#22b573"];
}

+ (UIColor *)color_c8c8c8{
    return [UIColor colorFromHexRGB:@"#c8c8c8"];
}
+ (UIColor *)color_placeholder{
    return [UIColor colorFromHexRGB:@"#e6e6e6"];
}
+ (UIColor *)defaultBlueColor{
    return [UIColor colorWithRed:0.000 green:0.478 blue:1.000 alpha:1.000];
}
+ (UIColor *)defaultRedColor{
    return [UIColor colorFromHexRGB:@"#ff372d"];
}
+ (UIColor *)disabledColor{
    return [UIColor colorFromHexRGB:@"#cccccc"];
}
+ (UIColor *)color_ffb440{
    return [UIColor colorFromHexRGB:@"#ffb440"];
}

+ (UIColor *)color_3fa9f5{
    return [UIColor colorFromHexRGB:@"#3fa9f5"];
    
}
+ (UIColor *)color_ff372d{
    
    return [UIColor colorFromHexRGB:@"#ff372d"];
    
}
+ (UIColor *)color_f3372d{
    
    return [UIColor colorFromHexRGB:@"#f3372d"];
    
}




@end
