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

- (void)findBackPasswordWithMobile:(NSString *)mobile password:(NSString *)password captcha:(NSString *)captcha completedHandler:(GGRequestCallbackBlock)completed;

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

- (void)getHealthRecordInfo:(NSString *)userId completedHandler:(GGRequestCallbackBlock)completed;
- (void)getHealthRecordDetailInfo:(NSString *)heathRecordId completedHandler:(GGRequestCallbackBlock)completed;

- (void)getNoticeListInfo:(NSString *)userId page:(NSInteger)page size:(NSInteger)size completedHandler:(GGRequestCallbackBlock)completed;
- (void)getNoticeDetailInfo:(NSString *)noticeId completedHandler:(GGRequestCallbackBlock)completed;

- (void)getBindDeviceListInfo:(NSString *)userId completedHandler:(GGRequestCallbackBlock)completed;
- (void)bindDevice:(NSString *)userId number:(NSString *)number completedHandler:(GGRequestCallbackBlock)completed;
- (void)unbindDevice:(NSString *)userId number:(NSString *)number completedHandler:(GGRequestCallbackBlock)completed;
- (void)chnageDevice:(NSString *)userId number:(NSString *)number completedHandler:(GGRequestCallbackBlock)completed;

- (void)getLocationSetting:(NSString *)deviceId completedHandler:(GGRequestCallbackBlock)completed;
- (void)setLocationSetting:(NSString *)deviceId locationSwitch:(NSInteger)locationSwitch completedHandler:(GGRequestCallbackBlock)completed;

- (void)getHeartRateSetting:(NSString *)deviceId completedHandler:(GGRequestCallbackBlock)completed;
- (void)setHeartRateSetting:(NSString *)deviceId heartRateSwitch:(NSInteger)heartRateSwitch completedHandler:(GGRequestCallbackBlock)completed;

- (void)getMedicineSetting:(NSString *)deviceId completedHandler:(GGRequestCallbackBlock)completed;
- (void)setMedicineSetting:(NSString *)deviceId medicationSwitch:(NSInteger)medicationSwitch t1:(NSString *)t1 t2:(NSString *)t2 t3:(NSString *)t3 completedHandler:(GGRequestCallbackBlock)completed;


@end
