//
//  UIViewController+Handle.h
//  HotYQ
//
//  Created by gm on 15/5/26.
//  Copyright (c) 2015年 hotyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Handle)


//添加左按钮
- (void)addLeftButton2NavWithTitle:(NSString *)title;
- (void)addLeftButton2NavWithImageName:(NSString *)imageName;


//添加右按钮
- (void)addRightButton2NavWithTitle:(NSString *)title;
- (void)addRightButton2NavWithImageName:(NSString *)imageName;
- (void)addTwoRightButton2NavWithImageName:(NSString *)imageName imageName:(NSString *)imageName2 actionL:(SEL)action actionR:(SEL)actionRight;

//添加返回按钮
- (void)addBackButton;
- (void)setRightButtonEnabled:(BOOL)flag;
- (void)setLeftButtonEnabled:(BOOL)flag;



- (void)leftBarButtonPressed:(id)leftBarButtonPressed;//重载
- (void)rightBarButtonPressed:(id)rightBarButtonPressed;//重载
- (void)backBarButtonPressed:(id)backBarButtonPressed;//重载

@end
