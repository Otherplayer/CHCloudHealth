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
    NSArray* colors2 = [NSArray arrayWithObjects:(id)toColor.CGColor, (id)toColor.CGColor, nil];
    CGGradientRef gradient2 = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors2, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height / 3.0), 0);
    
    CGContextDrawLinearGradient(context, gradient2, CGPointMake(0, size.height / 3.0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}



@end
