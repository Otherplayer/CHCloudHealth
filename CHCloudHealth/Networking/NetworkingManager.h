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

- (void)getLaunchAdvertisementCompletedHandler:(GGRequestCallbackBlock)completed;
#pragma mark - 登录注册

- (void)loginWithMobile:(NSString *)mobile password:(NSString *)password completedHandler:(GGRequestCallbackBlock)completed;
- (void)registerWithMobile:(NSString *)mobile password:(NSString *)password captcha:(NSString *)captcha completedHandler:(GGRequestCallbackBlock)completed;
- (void)getCaptchaWithMobile:(NSString *)mobile completedHandler:(GGRequestCallbackBlock)completed;



@end
