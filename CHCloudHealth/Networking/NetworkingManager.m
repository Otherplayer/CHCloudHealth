//
//  HYQNetworkingManager.m
//  HotYQ
//
//  Created by __无邪_ on 15/10/10.
//  Copyright © 2015年 hotyq. All rights reserved.
//

#import "NetworkingManager.h"
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * API URL 调用参数
 */

NSString *const kAPI_Login = HOTYQ_JAVA_API @"login";
NSString *const kAPI_Register = HOTYQ_JAVA_API @"register";
NSString *const kAPI_GetCaptcha = HOTYQ_JAVA_API @"sendSMS";
NSString *const kAPI_Logout = HOTYQ_JAVA_API @"logout";

NSString *const kAPI_ForgetPsd = HOTYQ_JAVA_API @"user/forgetPasswd";
NSString *const kAPI_UpdatePsd = HOTYQ_JAVA_API @"user/updatePasswd";
NSString *const kAPI_GetUserInfo = HOTYQ_JAVA_API @"user/getUserInfo";
NSString *const kAPI_UpdateUserInfo = HOTYQ_JAVA_API @"user/updateUserInfo";


NSString *const kAPI_PAGE = @"page";
NSString *const kAPI_SIZE = @"size";


////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////


@implementation NetworkingManager


#pragma mark - public interface



#pragma mark - 登录注册

- (void)loginWithMobile:(NSString *)mobile password:(NSString *)password completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"mobile":mobile,@"password":password};
    
    [self POST:kAPI_Login params:params memoryCache:NO diskCache:NO completed:completed];
}

- (void)registerWithMobile:(NSString *)mobile password:(NSString *)password captcha:(NSString *)captcha completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"mobile":mobile,@"password":password,@"mobileCaptcha":captcha};
    
    [self POST:kAPI_Register params:params memoryCache:NO diskCache:NO completed:completed];
}

- (void)getCaptchaWithMobile:(NSString *)mobile type:(NSString *)type completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"mobile":mobile,@"type":type};
    [self POST:kAPI_GetCaptcha params:params memoryCache:NO diskCache:NO completed:completed];
}

- (void)logoutWithUserId:(NSString *)userId completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"userId":userId};
    [self POST:kAPI_Logout params:params memoryCache:NO diskCache:NO completed:completed];
}



- (void)findBackPasswordCompletedHandler:(GGRequestCallbackBlock)completed{
    [self POST:kAPI_ForgetPsd params:nil memoryCache:NO diskCache:NO completed:completed];
}
- (void)updatePsd:(NSString *)userId completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"userId":userId};
    [self POST:kAPI_UpdatePsd params:params memoryCache:NO diskCache:NO completed:completed];
}
- (void)getUserInfo:(NSString *)userId completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"userId":userId};
    [self POST:kAPI_GetUserInfo params:params memoryCache:NO diskCache:NO completed:completed];
}
- (void)updateUserInfo:(NSString *)userId completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"userId":userId};
    [self POST:kAPI_UpdateUserInfo params:params memoryCache:NO diskCache:NO completed:completed];
}



////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////


#pragma mark - life
+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    static NetworkingManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[NetworkingManager alloc] init];
    });
    return manager;
}


////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////




@end
