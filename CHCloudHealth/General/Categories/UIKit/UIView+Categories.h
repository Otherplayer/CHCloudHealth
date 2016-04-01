//
//  UIView+Categories.h
//  HYQuan
//
//  Created by fqah on 12/10/15.
//  Copyright © 2015 fqah. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYQRedsDefaultView;
@interface UIView (Categories)
@property (nonatomic, retain) NSString *tagString;

- (UIView *)viewWithTagString:(NSString *)value;

///加圆角
- (void)addCornerRadius:(CGFloat)radius;
- (void)addCornerRadius:(CGFloat)radius tradition:(BOOL)flag;
- (void)addCornerTopRadius:(CGFloat)radius;
- (void)addCornerExceptLeftTopRadius:(CGFloat)radius;
-(void)addCornerExceptLeftTopBottomRadius:(CGFloat)radius;
-(void)addCornerExceptRightTopBottomRadius:(CGFloat)radius;
-(void)addCornerExceptBottomRadius:(CGFloat)radius;

@end
