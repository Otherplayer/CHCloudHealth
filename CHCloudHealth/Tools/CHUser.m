//
//  CHUser.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHUser.h"

NSString *const kUSER_ID = @"user_id";
NSString *const kUSER_NAME = @"username";
NSString *const kUSER_AVATAR = @"avatar";
NSString *const kUSER_DEVICE_ID = @"curDeviceId";
NSString *const kUSER_DEVICE_USER_ID = @"deviceUserId";
NSString *const kUSER_PHONE = @"phone";
NSString *const kUSER_SEX = @"sex";

@interface CHUser ()
@property (nonatomic, strong)NSUserDefaults *userDefaults;
@end

@implementation CHUser
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static CHUser *user;
    dispatch_once(&onceToken, ^{
        user = [[CHUser alloc] init];
        user.userDefaults = [NSUserDefaults standardUserDefaults];
    });
    return user;
}

- (void)loginWithInfo:(NSDictionary *)info{
    
    /// 1.保存用户信息
    NSString *uid = [NSString stringWithFormat:@"%@",info[@"data"][@"userId"]];
    NSString *app_token = [NSString stringWithFormat:@"%@",info[kAppToken]];
    NSString *deviceId = @"";
    if (![info[@"data"][kUSER_DEVICE_ID] isEmptyObject]) {
        deviceId = info[@"data"][kUSER_DEVICE_ID];
    }
    NSString *deviceUserId = @"";
    if (![info[@"data"][kUSER_DEVICE_USER_ID] isEmptyObject]) {
        deviceUserId = info[@"data"][kUSER_DEVICE_USER_ID];
    }
    
    [self.userDefaults setObject:uid forKey:kUSER_ID];
    [self.userDefaults setObject:deviceId forKey:kUSER_DEVICE_ID];
    [self.userDefaults setObject:deviceUserId forKey:kUSER_DEVICE_USER_ID];
    [self.userDefaults setObject:app_token forKey:kAppToken];
    [self.userDefaults synchronize];
    
}
- (NSString *)uid{
    return [self.userDefaults objectForKey:kUSER_ID] ? : @"";
}
- (NSString *)name{
    return [self.userDefaults objectForKey:kUSER_NAME];
}
- (void)setName:(NSString *)name{
    [self.userDefaults setObject:name forKey:kUSER_NAME];
}
- (void)setDeviceId:(NSString *)deviceId{
    [self.userDefaults setObject:deviceId forKey:kUSER_DEVICE_ID];
}
- (NSString *)deviceId{
    return [self.userDefaults objectForKey:kUSER_DEVICE_ID] ? : @"";
}

- (NSString *)deviceUserId{
    return [self.userDefaults objectForKey:kUSER_DEVICE_USER_ID] ? : @"";
}


- (NSString *)avatarurl{
    return [self.userDefaults objectForKey:kUSER_AVATAR];
}
- (NSString *)phoneNumber{
    return [self.userDefaults objectForKey:kUSER_PHONE];
}
- (void)setPhoneNumber:(NSString *)phoneNumber{
    [self.userDefaults setObject:phoneNumber forKey:kUSER_PHONE];
    [self.userDefaults synchronize];
}
- (NSString *)sex{
    return [self.userDefaults objectForKey:kUSER_SEX];
}
- (NSString *)token{
    return [self.userDefaults objectForKey:kAppToken];
}


- (void)getUserInformation{
    [self getUserInfo:self.uid];
}

- (void)getUserInfo:(NSString *)userId{
    [[NetworkingManager sharedManager] getUserInfo:userId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        if (success) {
            self.name = [NSString stringWithFormat:@"%@",responseData[@"data"][@"nickname"]];
            self.phoneNumber = [NSString stringWithFormat:@"%@",responseData[@"data"][@"mobile"]];
        }else{
            [HYQShowTip showTipTextOnly:errDesc dealy:1.2];
        }
    }];
}



- (BOOL)islogin{
    if (self.uid && self.uid.length > 0) {
        return YES;
    }
    return NO;
}




- (void)logout{
    [self.userDefaults removeObjectForKey:kAppToken];
    [self.userDefaults removeObjectForKey:kUSER_ID];
    [self.userDefaults removeObjectForKey:kUSER_NAME];
    [self.userDefaults removeObjectForKey:kUSER_AVATAR];
    [self.userDefaults removeObjectForKey:kUSER_PHONE];
    [self.userDefaults removeObjectForKey:kUSER_SEX];
    [self.userDefaults synchronize];
}




@end
