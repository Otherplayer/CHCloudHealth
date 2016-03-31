//
//  GGCache.m
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "GGCache.h"
#import "GGNTConfiguration.h"
@interface GGCache ()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation GGCache
#pragma mark - getters and setters
- (NSCache *)cache
{
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = kGGCacheCountLimit;
    }
    return _cache;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static GGCache *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GGCache alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public method


- (NSData *)fetchCachedDataWithURLStr:(NSString *)urlStr params:(NSDictionary *)requestParams{
    return [self fetchCachedDataWithKey:[self keyWithURLStr:urlStr params:requestParams]];
}


- (void)saveCacheWithData:(NSData *)cachedData
        URLStr:(NSString *)urlStr params:(NSDictionary *)requestParams{
    [self saveCacheWithData:cachedData key:[self keyWithURLStr:urlStr params:requestParams]];
}


- (void)deleteCacheWithURLStr:(NSString *)urlStr params:(NSDictionary *)requestParams{
    [self deleteCacheWithKey:[self keyWithURLStr:urlStr params:requestParams]];
}






- (NSData *)fetchCachedDataWithKey:(NSString *)key{
    GGCachedObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject.isOutdated || cachedObject.isEmpty) {
        return nil;
    } else {
        return cachedObject.content;
    }
}

- (void)saveCacheWithData:(NSData *)cachedData key:(NSString *)key{
    GGCachedObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject == nil) {
        cachedObject = [[GGCachedObject alloc] init];
    }
    [cachedObject updateContent:cachedData];
    [self.cache setObject:cachedObject forKey:key];
}

- (void)deleteCacheWithKey:(NSString *)key{
    [self.cache removeObjectForKey:key];
}

- (void)clean{
    [self.cache removeAllObjects];
}

- (NSString *)keyWithURLStr:(NSString *)urlStr params:(NSDictionary *)requestParams{
    return [NSString stringWithFormat:@"%@%@", urlStr, [requestParams urlParamsStringSignature:NO]];
}

@end
