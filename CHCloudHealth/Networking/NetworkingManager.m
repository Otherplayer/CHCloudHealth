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
NSString *const kAPI_BindingDeviceList = HOTYQ_JAVA_API @"device/listDevice";
//绑定设备
NSString *const kAPI_BindingDevice = HOTYQ_JAVA_API @"device/bindDevice";
//解除绑定
NSString *const kAPI_UNBindingDevice = HOTYQ_JAVA_API @"device/unbindDevice";
//切换设备
NSString *const kAPI_ChangeDevice = HOTYQ_JAVA_API @"device/changeDevice";
//获取位置检测设置
NSString *const kAPI_GetLocationSetting = HOTYQ_JAVA_API @"deviceUser/getLocationSetting";
//设置位置检测
NSString *const kAPI_SetLocationSetting = HOTYQ_JAVA_API @"deviceUser/setLocationSetting";



//#####4.7获取位置检测设置
//* URL:/deviceUser/getLocationSetting
//* Params:
//
//1.deviceId
//
//#####4.8设置位置检测
//* URL:/deviceUser/setLocationSetting
//* Params:
//
//1.deviceId
//2.locationSwitch
//
//#####4.9获取心率检测配置
//* URL:/deviceUser/getHeartRateSetting
//* Params:
//
//1.deviceId
//
//#####4.10设置心率检测
//* URL:/deviceUser/setHeartRateSetting
//* Params:
//
//1.deviceId
//2.heartRateSwitch
//#####4.11获取服药提醒设置
//* URL:/deviceUser/getMedicationSetting
//* Params:
//
//1.deviceId
//
//#####4.12设置服药提醒
//* URL:/deviceUser/setMedicationSetting
//* Params:
//
//1.deviceId
//2.medicationSwitch
//3.medicationTime1
//4.medicationTime2
//5.medicationTime3
//#####4.13获取SOS号
//* URL:/deviceUser/getSOSNumber
//* Params:
//
//1.deviceId
//
//#####4.14设置SOS号
//* URL:/deviceUser/setSOSNumber
//* Params:
//
//1.deviceId
//2.sosNum
//



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
//    
//#ifdef DEBUG
//    
//    
//#else
//    
//#endif
    
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

- (void)getHealthRecordInfo:(NSString *)userId completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"userId":userId};
    [self POST:kAPI_HealthRecord params:params memoryCache:NO diskCache:NO completed:completed];
}
- (void)getHealthRecordDetailInfo:(NSString *)heathRecordId completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"heathRecordId":heathRecordId};
    [self POST:kAPI_HealthRecordDetail params:params memoryCache:NO diskCache:NO completed:completed];
}

- (void)getNoticeListInfo:(NSString *)userId page:(NSInteger)page size:(NSInteger)size completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"userId":userId,kAPI_PAGE:@(page),kAPI_SIZE:@(size)};
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
- (void)bindDevice:(NSString *)userId number:(NSString *)number completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"userId":userId,@"imei":number};
    [self POST:kAPI_BindingDevice params:params memoryCache:NO diskCache:NO completed:completed];
}

- (void)unbindDevice:(NSString *)userId number:(NSString *)number completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"userId":userId,@"imei":number};
    [self POST:kAPI_UNBindingDevice params:params memoryCache:NO diskCache:NO completed:completed];
}
- (void)chnageDevice:(NSString *)userId number:(NSString *)number completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"userId":userId,@"imei":number};
    [self POST:kAPI_ChangeDevice params:params memoryCache:NO diskCache:NO completed:completed];
}


- (void)getLocationSetting:(NSString *)deviceId completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"deviceId":deviceId};
    [self POST:kAPI_GetLocationSetting params:params memoryCache:NO diskCache:NO completed:completed];
}
- (void)setLocationSetting:(NSString *)deviceId locationSwitch:(NSInteger)locationSwitch completedHandler:(GGRequestCallbackBlock)completed{
    NSDictionary *params = @{@"deviceId":deviceId,@"locationSwitch":@(locationSwitch)};
    [self POST:kAPI_SetLocationSetting params:params memoryCache:NO diskCache:NO completed:completed];
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
