//
//  GGDiskCache.h
//  GGNetwoking
//
//  Created by __无邪_ on 15/10/3.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FQAHDiskCachedObject.h"

@interface FQAHDiskCache : NSObject

+ (instancetype)sharedInstance;

- (NSData *)fetchCachedDataWithURLStr:(NSString *)urlStr params:(NSDictionary *)requestParams;

- (void)saveCacheWithData:(NSData *)cachedData
                   URLStr:(NSString *)urlStr params:(NSDictionary *)requestParams;

- (void)deleteCacheWithURLStr:(NSString *)urlStr params:(NSDictionary *)requestParams;


@end
