//
//  AppGlobal.h
//  FQAHProject
//
//  Created by __无邪_ on 3/31/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#ifndef AppGlobal_h
#define AppGlobal_h

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////


#define kMainWidth [[UIScreen mainScreen] bounds].size.width
#define kMainHeight [[UIScreen mainScreen] bounds].size.height


#define IS_IPHONE4      ([UIScreen mainScreen].bounds.size.height == 480.0f)
#define IS_IPHONE5      ([UIScreen mainScreen].bounds.size.height == 568.0f)
#define IS_IPHONE6      ([UIScreen mainScreen].bounds.size.height == 667.0f)//375w
#define IS_IPHONE6_PLUS ([UIScreen mainScreen].bounds.size.height == 736.0f)//414w

#define IS_IOS7    ((([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)&&([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0))? (YES):(NO))
#define IS_IOS8    ((([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0)&&([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0))? (YES):(NO))
#define IS_IOS9    ((([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0)&&([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0))? (YES):(NO))

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

#define WS(weakSelf)          __weak __typeof(&*self)weakSelf = self;

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

#define kNotificationMenuController @"kNotificationMenuController"
#define kAppToken @"kAppToken-CH"

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

#import "FQAHCategoriesHeader.h"
#import <AFNetworking.h>
#import <MagicalRecord/MagicalRecord.h>
#import "NetworkingManager.h"
#import "SWRevealViewController.h"
#import "GlobalCategoryHeader.h"
#import "CHBaseNavigationController.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "HYQHelperHUD.h"
#import "CHUser.h"
#import "HYQActionSheet.h"
#import "HYQAlertView.h"


#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
//#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
//#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件


////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////


static inline NSString *FQAHStringFromDate(NSString *dateFormat, NSDate *date) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter stringFromDate:date];
}

#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NSLog(...)
#endif

#endif /* AppGlobal_h */
