//
//  UIColor+Random.m
//  IOS-Categories
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)
+ (UIColor *)RandomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}

+ (UIColor *)defaultColor{
    return [UIColor colorFromHexRGB:@"0097ff"];
}

+ (UIColor *)color_33333{
    return [UIColor colorFromHexRGB:@"333333"];
}//暗灰色

+ (UIColor *)color_66666{
    return [UIColor colorFromHexRGB:@"666666"];
}//淡灰色

+ (UIColor *)color_b3b3b3{
    return [UIColor colorFromHexRGB:@"b3b3b3"];
}//浅字和灰线

+ (UIColor *)color_f2f2f2{
    return [UIColor colorFromHexRGB:@"f2f2f2"];
}//背景色，淡白

+ (UIColor *)color_ca4341{
    return [UIColor colorFromHexRGB:@"ca4341"];
}//红色

@end
