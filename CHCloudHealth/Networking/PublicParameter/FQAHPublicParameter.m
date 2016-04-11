//
//  HYQPublicParameter.m
//  HYQuan
//
//  Created by fqah on 12/11/15.
//  Copyright © 2015 fqah. All rights reserved.
//

#import "FQAHPublicParameter.h"
//#import <AdSupport/ASIdentifierManager.h>
//#import "UIDevice+Hardware.h"
@implementation FQAHPublicParameter


+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static FQAHPublicParameter *paramter;
    dispatch_once(&onceToken, ^{
        paramter = [[FQAHPublicParameter alloc] init];
    });
    return paramter;
}

/**
 *  接口参数
 *  uid
 *  token
 *  手机唯一标示符
 *  手机型号
 *  系统版本名称
 *  系统版本号
 *  app名字
 *  app版本号
 
 */

+ (NSDictionary *)publicParameter{
//    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    
    
    
    // app build版本
    //NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    
////    app_type   手机型号
//    NSString *phoneModel =   [[UIDevice currentDevice] model];
//    NSString *hardwareStr =  [[UIDevice currentDevice] hardwareSimpleDescription];
////    NSString *size = NSStringFromCGSize(CGSizeMake(kMainWidth, kMainHeight));
//    NSString *size = [NSString stringWithFormat:@"%.f-%.f",kMainWidth,kMainHeight];
////    app_os_ver 系统版本号
//    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
////    app_name   app名字
//    NSString *appName =      [infoDictionary objectForKey:@"CFBundleDisplayName"];
////    app_ver    app版本号
//    NSString *appVersion =   [infoDictionary objectForKey:@"CFBundleShortVersionString"];
////    app_token  用户的登录状态标识符
    ////    uid        用户的id
    //    NSString *uid        =   [user objectForKey:kUSER_ID]?:@"";
    //    //token 推送
    //    NSString *devToken = [[NSUserDefaults standardUserDefaults] objectForKey:kRCloudDeviceToken];
    //    //唯一广告标识
    //    NSString *IDFA = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //    NSString *uuid = IDFA;
    
    NSString *appToken  =   [user objectForKey:kAppToken]?:@"";
    //NSString *userId    =   [user objectForKey:@"userId"]?:@"";
    NSString *deviceIdentifier = [NSString UUIDString];
    
    NSDictionary *publicParameter = [NSDictionary dictionaryWithObjectsAndKeys:
                                     appToken, kAppToken,
                                     deviceIdentifier,@"deviceIdentifier",
                                     @"ios",@"device",
//                                     @"userId",userId,
                                     nil];
    return publicParameter;
}


@end
