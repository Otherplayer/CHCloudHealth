//
//  HYQDatePickerView.h
//  GGPickerView
//
//  Created by __无邪_ on 15/8/4.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+HYQFormatter.h"
@interface HYQDatePickerView : UIView
@property (nonatomic, strong)void(^didClickedOkAction)(NSString *result);
-(void)showInView:(UIView *)superView withSelectDate:(NSString *)strSelectDate;//strSelectDate格式：（2015-8-21,11:00）
-(void)showInView:(UIView *)superView withSelectDate:(NSString *)strSelectDate timeOnly:(BOOL)timeOnly;
@end
