//
//  GGDiskCache.m
//  GGNetwoking
//
//  Created by __无邪_ on 15/10/3.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "FQAHDiskCache.h"
#import "FQAHNTConfiguration.h"

@interface FQAHDiskCache ()

@end

@implementation FQAHDiskCache

#pragma mark - life cycle
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static FQAHDiskCache *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FQAHDiskCache alloc] init];
    });
    return sharedInstance;
}




#pragma mark - public methods

- (NSData *)fetchCachedDataWithURLStr:(NSString *)urlStr params:(NSDictionary *)requestParams{
    NSString *identifier = [self keyWithURLStr:urlStr params:requestParams];
    FQAHDiskCachedObject *cachedObject = [FQAHDiskCachedObject fetchCachedDataWithIdentifier:identifier];
    if (cachedObject == nil) {
        return nil;
    }
    return cachedObject.content;
}

- (void)saveCacheWithData:(NSData *)cachedData
                   URLStr:(NSString *)urlStr params:(NSDictionary *)requestParams{
    NSString *identifier = [self keyWithURLStr:urlStr params:requestParams];
    
    if ([self shouldNotHandleCapicaty]) {//当不可以通过操作手机容量获取存储空间时，直接返回不再保存
        return;
    }
    
    [FQAHDiskCachedObject saveContent:cachedData identifier:identifier];
}

- (void)deleteCacheWithURLStr:(NSString *)urlStr params:(NSDictionary *)requestParams{
    NSString *identifier = [self keyWithURLStr:urlStr params:requestParams];
    [FQAHDiskCachedObject deleteCachedObjectWithIdentifier:identifier];
}








#pragma mark - private

- (NSString *)keyWithURLStr:(NSString *)urlStr params:(NSDictionary *)requestParams{
    return [NSString stringWithFormat:@"%@%@", urlStr, [requestParams urlParamsStringSignature:NO]];
}

- (BOOL)shouldNotHandleCapicaty{
//    BOOL shouldDeleteOldDatas = [self dataSpace] > kGGDiskCacheCapacityLimitM * 1024.0 || [self deviceFreeDiskSpace] <= 10 * 1024;
//
//    if (shouldDeleteOldDatas) {
//        NSLog(@"当前手机存储空间： %lld KB \n当前手机数据空间：%lld M",[self deviceFreeDiskSpace],[self dataSpace]);
//        
//        //1. 手机存储空间过小，删除两天前的数据
//        NSDate *beforeYesterday = [NSDate dateWithTimeIntervalSinceNow:- 2 * 3600];
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"lastUpdateTime > %@",beforeYesterday];
//        [FQAHDiskCachedObject MR_deleteAllMatchingPredicate:predicate];
//        
//        //2. 删除后，空间还是太小(小于 10 M), 删除剩下的一半数据
//        if ([self deviceFreeDiskSpace] <= 10 * 1024) {
////            NSArray *oldDatas = [[FQAHDiskCachedObject MR_findAll] sortedArrayUsingComparator:^NSComparisonResult(FQAHDiskCachedObject*  _Nonnull obj1, FQAHDiskCachedObject*  _Nonnull obj2) {
////                return [obj1.lastUpdateTime compare:obj2.lastUpdateTime];
////            }];
////            if (oldDatas && oldDatas.count > 1) {
////                for (int i = 0; i < oldDatas.count / 2; i++) {
////                    FQAHDiskCachedObject *objectCache = oldDatas[i];
////                    [objectCache MR_deleteEntity];
////                }
////            }
//        }
//        
//        // 3.还小，就提示用户空间不足
//        if ([self deviceFreeDiskSpace] <= 10 * 1024) {
//            //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key != %@",[NSNull null]];
//            //[FQAHDiskCachedObject MR_deleteAllMatchingPredicate:predicate];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"手机存储空间不足！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                [alertView show];
//            });
//            return YES;
//        }
//        
//#ifdef DEBUG
//        NSArray *datasCount = [FQAHDiskCachedObject MR_findAll];
//        NSLog(@"本地数据数量： %ld",datasCount.count);
//#endif
//        
//    }
//    
    
    
    return NO;
}

- (long long)deviceFreeDiskSpace{
    return [UIDevice freeDiskSpaceInBytes];
}

- (long long)dataSpace{
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    filePath = [filePath stringByAppendingPathComponent:@"Application Support"];
    return [NSFileManager fileSizeAtPath:filePath];
}

@end
