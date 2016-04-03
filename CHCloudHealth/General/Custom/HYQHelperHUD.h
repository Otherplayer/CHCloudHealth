//
//  GGProgressHUD.h
//  GGProgressHUD
//
//  Created by __无邪_ on 15/5/1.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import <MBProgressHUD.h>

#define HYQShowTip [HYQHelperHUD sharedInstance]

typedef NS_ENUM(NSUInteger, GGProgressHUDMaskType) {
    GGProgressHUDMaskTypeNone = 1,  // allow user interactions while HUD is displayed
    GGProgressHUDMaskTypeClear = 2, // don't allow user interactions
};

typedef NS_ENUM(NSInteger, GGProgressHUDPosition) {
    GGProgressHUDPosition_top,     // show Top
    GGProgressHUDPosition_center,
    GGProgressHUDPosition_bottom
};

@interface HYQHelperHUD : MBProgressHUD
@property (nonatomic, unsafe_unretained) GGProgressHUDMaskType maskType;

+ (instancetype)sharedInstance;
+ (instancetype)showTip:(NSString *)text afterDelay:(NSTimeInterval)delay; //自定义view
- (void)hideImmediately;

// 在当前页面显示提示
- (void)showTipInView:(UIView *)view tip:(NSString *)text dealy:(NSTimeInterval)dealy;
- (void)showProgressInView:(UIView *)view tip:(NSString *)text afterDelay:(NSTimeInterval)delay;
- (void)hideHud;



- (void)showTipTextOnly:(NSString *)text dealy:(NSTimeInterval)dealy;
- (void)showProgressWithText:(NSString *)text dealy:(NSTimeInterval)dealy;
- (void)showHProgressWithText:(NSString *)text dealy:(NSTimeInterval)dealy;
- (void)showProgress:(NSString*)progress;
- (void)showTipTextOnly:(NSString *)text dealy:(NSTimeInterval)dealy position:(GGProgressHUDPosition)position;


@end
