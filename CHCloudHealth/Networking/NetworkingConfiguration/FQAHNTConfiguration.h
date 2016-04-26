//
//  FQAHNTConfiguration.h
//  FQAHProject
//
//  Created by __无邪_ on 4/1/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#ifndef FQAHNTConfiguration_h
#define FQAHNTConfiguration_h


//#define SHOULD_USE_JSONMODEL   /*是否调用JSONModel*/

#import "BASEModel.h"



//////////////////////////////////////
#ifdef DEBUG
#define IS_OFF_LINE
#endif
//////////////////////////////////////


#ifdef IS_OFF_LINE
#define HOTYQ_JAVA_API @"http://221.1.104.218:8081/healthcloud-mobile/"
#else
#define HOTYQ_JAVA_API @"http://chyjk.chyy.com.cn:8081/"          //线上接口
#endif



static NSTimeInterval GGNetworkTimeoutInterval   = 60;    // 超时时间
static NSTimeInterval kGGCacheOutdateTimeSeconds = 300;   // 5分钟的cache过期时间
static NSUInteger     kGGCacheCountLimit         = 1000;  // 最多1000条cache
static NSUInteger     kGGDiskCacheCapacityLimitM = 500;   // 最大本地缓存容量 500 M

typedef NS_ENUM(NSInteger, GGResponseErrCodeType){
    GGServiceResponseErrCodeTypeNone = 1000,     //服务端返回错误代码
    GGServiceResponseErrCodeTypeSeverErr = 500,
    GGResponseErrCodeTypeEmailExisted = 301,
    GGResponseErrCodeTypeEmail_PsdError = 302,
    GGResponseErrCodeTypeOldPsdError = 303,
    GGResponseErrCodeTypeEmailNotExisted = 888,
};

typedef NS_ENUM(NSUInteger, GGURLResponseStatus){
    GGURLResponseStatusSuccess,       //请求是否成功只考虑是否成功收到服务器反馈。
    GGURLResponseStatusErrorTimeout,  //请求超时
    GGURLResponseStatusErrorNoNetwork //默认除了超时以外的错误都是无网络错误。
};



#ifdef SHOULD_USE_JSONMODEL
typedef void (^GGRequestCallbackBlock)(BOOL success, NSString *errDesc, BASEModel *model);
#else
typedef void (^GGRequestCallbackBlock)(BOOL success, NSString *errDesc, id responseData);
#endif

#endif /* FQAHNTConfiguration_h */
