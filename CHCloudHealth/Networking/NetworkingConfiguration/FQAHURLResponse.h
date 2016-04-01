//
//  GGURLResponse.h
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FQAHNTConfiguration.h"
@interface FQAHURLResponse : NSObject
@property (nonatomic, copy) NSDictionary *requestParams;        //请求参数
@property (nonatomic, copy) NSString *requestUrlStr;            //请求接口地址

@property (nonatomic, copy, readonly) id responseObject;        //处理后的数据
@property (nonatomic, copy, readonly) NSString *responseString; //json字符串
@property (nonatomic, copy, readonly) NSData *responseData;     //二进制数据
@property (nonatomic, copy, readonly) NSURLRequest *request;

@property (nonatomic, strong, readonly) NSHTTPURLResponse *response;
@property (nonatomic, assign, readonly) GGURLResponseStatus status;
@property (nonatomic, assign, readonly) BOOL isCache;
@property (nonatomic, assign, readonly) BOOL isDiskCache;

// isCache is NO
- (instancetype)initWithResponse:(NSHTTPURLResponse *)response request:(NSURLRequest *)request responseObject:(id)responseObject responseString:(NSString *)responseString responseData:(NSData *)responseData status:(GGURLResponseStatus)status;

// isCache is YES, isDiskCache is NO
- (instancetype)initWithMemoryData:(NSData *)data;

// isCache is NO, isDiskCache is YES
- (instancetype)initWithDiskData:(NSData *)data;

@end
