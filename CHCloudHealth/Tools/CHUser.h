//
//  CHUser.h
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHUser : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatarurl;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *sex;



+ (instancetype)sharedInstance;

- (void)loginWithInfo:(NSDictionary *)info;
- (void)getUserInformation;


- (BOOL)islogin;

@end
