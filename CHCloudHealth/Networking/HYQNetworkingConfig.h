//
//  HYQNetworkingConfig.h
//  HotYQ
//
//  Created by __无邪_ on 15/10/10.
//  Copyright © 2015年 hotyq. All rights reserved.
//

#ifndef HYQNetworkingConfig_h
#define HYQNetworkingConfig_h
#import "NetEnvironmentConfig.h"
#pragma mark - 登录


NSString *const kAPI_Login = HOTYQ_JAVA_API @"userController/login";
NSString *const kAPI_Register = HOTYQ_JAVA_API @"userController/register";
NSString *const kAPI_GetCaptcha = HOTYQ_JAVA_API @"userController/sendSmsCapctha";




#endif