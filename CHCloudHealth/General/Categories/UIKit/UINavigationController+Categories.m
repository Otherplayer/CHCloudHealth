//
//  UINavigationController+Categories.m
//  HYQuan
//
//  Created by fqah on 12/22/15.
//  Copyright © 2015 fqah. All rights reserved.
//

#import "UINavigationController+Categories.h"

@implementation UINavigationController (Categories)
- (void)applyApprenceWithBarTintColor:(UIColor *)tintColor fontColor:(UIColor *)fontColor{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UINavigationBar *navigationBar = self.navigationBar;
    
    //    NSShadow *shadow = [[NSShadow alloc] init];
    //    shadow.shadowBlurRadius = 5;
    //    shadow.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    //    shadow.shadowOffset = CGSizeMake(1.2, 1.2);
    
    [navigationBar setTitleTextAttributes:@{
                                            NSFontAttributeName : [UIFont systemFontOfSize:17.f],
                                            NSForegroundColorAttributeName : fontColor,
                                            //                                            NSShadowAttributeName: shadow,
                                            //                                            NSVerticalGlyphFormAttributeName:@1
                                            }];
    [navigationBar setTintColor:fontColor];    //设置字体颜色
    [navigationBar setBarTintColor:tintColor]; //设置背景色
    //    [navigationBar setBackgroundImage:[UIImage imageNamed:@"5.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    [navigationBar setTranslucent:YES];        //关透明
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    iOS7之后由于navigationBar.translucent默认是YES，坐标零点默认在（0，0）点  当不透明的时候，零点坐标在（0，64）；如果你想设置成透明的，而且还要零点从（0，64）开始，那就添加：self.edgesForExtendedLayout = UIRectEdgeNone;
}
@end
