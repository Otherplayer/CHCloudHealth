//
//  NSFileManager+GGNetworkingMethods.m
//  GGNetwoking
//
//  Created by __无邪_ on 15/10/5.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "NSFileManager+GGNetworkingMethods.h"

@implementation NSFileManager (GGNetworkingMethods)
+ (long long)fileSizeAtPath:(NSString *)filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
//    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
//    }
//    return 0;
}
@end
