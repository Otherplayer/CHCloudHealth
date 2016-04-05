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
//register  注册
//reset      找回密码
//bind      绑定亲情号
- (void)getCaptchaWithMobile:(NSString *)mobile type:(NSString *)type completedHandler:(GGRequestCallbackBlock)completed;



@end
