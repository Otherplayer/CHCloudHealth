//
//  NSFileManager+FQAHCategories.m
//  FQAHProject
//
//  Created by __无邪_ on 3/31/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "NSFileManager+FQAHCategories.h"

@implementation NSFileManager (FQAHCategories)
+ (long long)fileSizeAtPath:(NSString *)filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    //    if ([manager fileExistsAtPath:filePath]){
    return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    //    }
    //    return 0;
}
@end
