//
//  HYQNetworkingManager.h
//  HotYQ
//
//  Created by __无邪_ on 15/10/10.
//  Copyright © 2015年 hotyq. All rights reserved.
//

#import "FQAHBaseNetwork.h"
#import <JSONModel.h>
#import "FQAHReachibility.h"

@interface NetworkingManager : FQAHBaseNetwork

+ (instancetype)sharedManager;

#pragma mark - 登录注册

- (void)loginWithMobile:(NSString *)mobile password:(NSString *)password completedHandler:(GGRequestCallbackBlock)completed;

- (void)registerWithMobile:(NSString *)mobile password:(NSString *)password captcha:(NSString *)captcha completedHandler:(GGRequestCallbackBlock)completed;

// (register注册reset找回密码bind绑定亲情号)
- (void)getCaptchaWithMobile:(NSString *)mobile type:(NSString *)type completedHandler:(GGRequestCallbackBlock)completed;

- (void)logoutWithUserId:(NSString *)userId completedHandler:(GGRequestCallbackBlock)completed;

- (void)findBackPasswordCompletedHandler:(GGRequestCallbackBlock)completed;

- (void)updatePsd:(NSString *)userId completedHandler:(GGRequestCallbackBlock)completed;

- (void)getUserInfo:(NSString *)userId completedHandler:(GGRequestCallbackBlock)completed;

- (void)updateUserInfo:(NSString *)userId completedHandler:(GGRequestCallbackBlock)completed;

- (void)getDeviceInfo:(NSString *)deviceUserId completedHandler:(GGRequestCallbackBlock)completed;

- (void)getHealthTypeInfo:(NSString *)deviceUserId completedHandler:(GGRequestCallbackBlock)completed;

// yyyy-MM-dd
- (void)getHeartRateInfo:(NSString *)deviceUserId date:(NSString *)date completedHandler:(GGRequestCallbackBlock)completed;

- (void)getBloodPressureInfo:(NSString *)deviceUserId date:(NSString *)date completedHandler:(GGRequestCallbackBlock)completed;

- (void)getBloodSugarInfo:(NSString *)deviceUserId date:(NSString *)date completedHandler:(GGRequestCallbackBlock)completed;

- (void)getLocationInfo:(NSString *)deviceUserId date:(NSString *)date completedHandler:(GGRequestCallbackBlock)completed;

- (void)getHealthRecordInfo:(NSString *)deviceUserId completedHandler:(GGRequestCallbackBlock)completed;
- (void)getHealthRecordDetailInfo:(NSString *)heathRecordId completedHandler:(GGRequestCallbackBlock)completed;

- (void)getNoticeListInfo:(NSString *)userId completedHandler:(GGRequestCallbackBlock)completed;

- (void)getNoticeDetailInfo:(NSString *)noticeId completedHandler:(GGRequestCallbackBlock)completed;


@end
