//
//  UIColor+HexRGB.h
//  HotYQ
//
//  Created by gm on 15/1/28.
//  Copyright (c) 2015年 DaMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (HexRGB)


+ (UIColor *) colorFromHexRGB: (NSString *)color;

+ (UIImage *)imageWithColor:(UIColor *)color;

@end
