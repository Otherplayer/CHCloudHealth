//
//  UIStoryboard+Categories.h
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHBaseNavigationController.h"

@interface UIStoryboard (Categories)
+ (instancetype)mainStoryboard;
+ (instancetype)loginStoryboard;

- (UIViewController *)messageController;
- (CHBaseNavigationController *)loginController;
- (CHBaseNavigationController *)bindController;
- (UIViewController *)statisticsController;
- (UIViewController *)changeNameController;
- (UIViewController *)locationMonitorController;
- (UIViewController *)healthReportController;
- (UIViewController *)locationAreaController;
- (UIViewController *)setTimeIntervalController;



- (UIViewController *)resetPsdStep2Controller;

@end
