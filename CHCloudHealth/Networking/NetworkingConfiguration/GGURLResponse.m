//
//  GGURLResponse.m
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "GGURLResponse.h"
@interface GGURLResponse ()
@property (nonatomic, copy, readwrite) NSString *responseString;
@property (nonatomic, copy, readwrite) id responseObject;
@property (nonatomic, copy, readwrite) NSURLRequest *request;
@property (nonatomic, copy, readwrite) NSData *responseData;
@property (nonatomic, assign, readwrite) BOOL isCache;
@property (nonatomic, assign, readwrite) BOOL isDiskCache;
@property (nonatomic, assign, readwrite) GGURLResponseStatus status;
@property (nonatomic, strong, readwrite) NSHTTPURLResponse *response;
@end

@implementation GGURLResponse

- (instancetype)initWithMemoryData:(NSData *)data{
    self = [super init];
    if (self) {
        self.responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.request = nil;
        self.status = [self responseStatusWithError:nil];
        self.responseData = [data copy];
        self.responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = YES;
        self.isDiskCache = NO;
    }
    return self;
}

- (instancetype)initWithDiskData:(NSData *)data{
    self = [super init];
    if (self) {
        self.responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.request = nil;
        self.status = [self responseStatusWithError:nil];
        self.responseData = [data copy];
        self.responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = NO;
        self.isDiskCache = YES;
    }
    return self;
}

#pragma mark - life cycle

- (instancetype)initWithResponse:(NSHTTPURLResponse *)response request:(NSURLRequest *)request responseObject:(id)responseObject responseString:(NSString *)responseString responseData:(NSData *)responseData status:(GGURLResponseStatus)status{
    self = [super init];
    if (self) {
        self.response = response;
        self.request = request;
        self.status = status;
        self.responseObject = responseObject;
        self.responseString = responseString;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
    }
    return self;

}

#pragma mark - private methods
- (GGURLResponseStatus)responseStatusWithError:(NSError *)error{
    if (error) {
        GGURLResponseStatus result = GGURLResponseStatusErrorNoNetwork;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = GGURLResponseStatusErrorNoNetwork;
        }
        return result;
    } else {
        return GGURLResponseStatusSuccess;
    }
}




@end
