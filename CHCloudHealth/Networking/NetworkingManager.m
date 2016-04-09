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

//获取统计信息
NSString *const kAPI_DeviceInfo = HOTYQ_JAVA_API @"deviceUser/getStatisInfo";
//健康分类信息
NSString *const kAPI_HealthTypeInfo = HOTYQ_JAVA_API @"deviceUser/getHealthTypeInfoList";
//获取心率数据
NSString *const kAPI_HeartRateInfo = HOTYQ_JAVA_API @"deviceUser/getHeartRateData";
//获取血压统计
NSString *const kAPI_BloodPressureInfo = HOTYQ_JAVA_API @"deviceUser/getBloodPressureData";
//获取血糖数据
NSString *const kAPI_BloodSugarInfo = HOTYQ_JAVA_API @"deviceUser/getBloodSugarData";
//获取血糖数据
NSString *const kAPI_LocationInfo = HOTYQ_JAVA_API @"deviceUser/getPositionData";
//获取健康档案列表
NSString *const kAPI_HealthRecord = HOTYQ_JAVA_API @"deviceUser/getHealthRecordList";
//查看健康档案详细
NSString *const kAPI_HealthRecordDetail = HOTYQ_JAVA_API @"deviceUser/getHealthRecordDetail";

//公告列表
NSString *const kAPI_NoticeList = HOTYQ_JAVA_API @"notice/list";
//公告列表
NSString *const kAPI_NoticeDetail = HOTYQ_JAVA_API @"notice/getDetail";

//绑定设备列表
NSString *const kAPI_BindingDeviceList = HOTYQ_JAVA_API @"notice/getDetail";


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



- (void)findBackPasswordWithMobile:(NSString *)mobile password:(NSString *)password captcha:(NSString *)captcha completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"mobile":mobile,@"password":password,@"mobileCaptcha":captcha};
    [self POST:kAPI_ForgetPsd params:params memoryCache:NO diskCache:NO completed:completed];
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

- (void)getDeviceInfo:(NSString *)deviceUserId completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"deviceUserId":deviceUserId};
    [self POST:kAPI_DeviceInfo params:params memoryCache:YES diskCache:YES completed:completed];
}
- (void)getHealthTypeInfo:(NSString *)deviceUserId completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"deviceUserId":deviceUserId};
    [self POST:kAPI_HealthTypeInfo params:params memoryCache:YES diskCache:YES completed:completed];
}
- (void)getHeartRateInfo:(NSString *)deviceUserId date:(NSString *)date completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"deviceUserId":deviceUserId,@"queryDate":date};
    [self POST:kAPI_HeartRateInfo params:params memoryCache:NO diskCache:NO completed:completed];
}

- (void)getBloodPressureInfo:(NSString *)deviceUserId date:(NSString *)date completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"deviceUserId":deviceUserId,@"queryDate":date};
    [self POST:kAPI_BloodPressureInfo params:params memoryCache:NO diskCache:NO completed:completed];
}

- (void)getBloodSugarInfo:(NSString *)deviceUserId date:(NSString *)date completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"deviceUserId":deviceUserId,@"queryDate":date};
    [self POST:kAPI_BloodSugarInfo params:params memoryCache:NO diskCache:NO completed:completed];
}

- (void)getLocationInfo:(NSString *)deviceUserId date:(NSString *)date completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"deviceUserId":deviceUserId,@"queryDate":date};
    [self POST:kAPI_LocationInfo params:params memoryCache:NO diskCache:NO completed:completed];
}

- (void)getHealthRecordInfo:(NSString *)deviceUserId completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"deviceUserId":deviceUserId};
    [self POST:kAPI_HealthRecord params:params memoryCache:NO diskCache:NO completed:completed];
}
- (void)getHealthRecordDetailInfo:(NSString *)heathRecordId completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"heathRecordId":heathRecordId};
    [self POST:kAPI_HealthRecordDetail params:params memoryCache:NO diskCache:NO completed:completed];
}

- (void)getNoticeListInfo:(NSString *)userId completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"userId":userId};
    [self POST:kAPI_NoticeList params:params memoryCache:NO diskCache:NO completed:completed];
}
- (void)getNoticeDetailInfo:(NSString *)noticeId completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"noticeId":noticeId};
    [self POST:kAPI_NoticeDetail params:params memoryCache:NO diskCache:NO completed:completed];
}

- (void)getBindDeviceListInfo:(NSString *)userId completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"userId":userId};
    [self POST:kAPI_BindingDeviceList params:params memoryCache:NO diskCache:NO completed:completed];
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


//3 ResponseCode字典对应表
//
//通用响应码
//相应码
//字段描述
//9001
//服务器异常
//9002
//参数不合法
//9003
//短信验证码发送失败
//9004
//短信验证码发送频繁
//9005
//短信验证码错误
//
//1.注册响应码
//相应码
//字段描述
//1000
//注册成功
//1001
//注册失败
//1002
//手机号码已存在
//2.登陆响应码：
//相应码
//字段描述
//2000
//登陆成功
//2001
//用户名或密码错误
//2002
//用户已经被禁用
//3.重置密码
//相应码
//字段描述
//3000
//重置成功
//3001
//重置失败


@end
