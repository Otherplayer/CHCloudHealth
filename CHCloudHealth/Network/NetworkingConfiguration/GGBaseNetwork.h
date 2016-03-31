//
//  GGBaseNetwork.h
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "GGNTConfiguration.h"
#import "HYQBASEModel.h"

extern NSString *const kIMGKey;


@interface GGBaseNetwork : AFHTTPRequestOperationManager
//*(+ (instancetype)sharedNetwork;)*//

/// post 请求
- (void)POST:(NSString *)URLString params:(id)parameters memoryCache:(BOOL)memoryCache diskCache:(BOOL)diskCache completed:(GGRequestCallbackBlock)completed;

/// post 上传图片 (/** 数组images里面数据为dictionary{kIMGKey:image} **/)
- (void)POST:(NSString *)URLString params:(id)parameters images:(NSArray *)images imageSConfig:(NSString *)serviceName completed:(GGRequestCallbackBlock)completed;

/// get 请求
- (void)GET:(NSString *)URLString params:(id)parameters memoryCache:(BOOL)memoryCache diskCache:(BOOL)diskCache completed:(GGRequestCallbackBlock)completed;


@end
