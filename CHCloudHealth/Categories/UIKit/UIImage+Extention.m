//
//  UIImage+Extention.m
//  HYQuan
//
//  Created by J on 15/12/16.
//  Copyright © 2015年 fqah. All rights reserved.
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)
+(UIImage*) ImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
