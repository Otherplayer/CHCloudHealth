//
//  UIImage+Orientation.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/1/4.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Orientation)

+ (UIImage *)fixOrientation:(UIImage *)srcImg;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

/*垂直翻转*/
- (UIImage *)flipVertical;
/*水平翻转*/
- (UIImage *)flipHorizontal;
// 通过本地url 获取视频缩略图
+ (UIImage *)getThumbnailImage:(NSString *)videoURL;

+ (UIImage *)screenshot;

+ (UIImage *)screenshotWithView:(UIView *)aView limitWidth:(CGFloat)maxWidth;

@end
