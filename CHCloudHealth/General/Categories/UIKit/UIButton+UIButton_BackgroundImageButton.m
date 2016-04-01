//
//  UIButton+UIButton_BackgroundImageButton.m
//  HotYQ
//
//  Created by xiaxiangquan on 15/3/3.
//  Copyright (c) 2015年 hotyq. All rights reserved.
//

#import "UIButton+UIButton_BackgroundImageButton.h"

@implementation UIButton (UIButton_BackgroundImageButton)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+(UIImage *)imageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
