//
//  NSFileManager+SaveAndRead.h
//  HotYQ
//
//  Created by 王建 on 15/8/14.
//  Copyright (c) 2015年 hotyq. All rights reserved.
/*
 
 plist文件  读写 删除
 */

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, DirectoryType)
{
    DirectoryTypeMainBundle = 0,
    DirectoryTypeLibrary,
    DirectoryTypeDocuments,
    DirectoryTypeCache
};

@interface NSFileManager (SaveAndRead)

+ (BOOL)saveHistoryArr:(NSString *)key path:(NSString *)path;

+ (NSString *)getPath:(DirectoryType)path;
//+ (NSString *)saveFile:(UIImage *)iamge type:(NSString *)type Topath:(DirectoryType)path  withFilename:(NSString *)fileName;
+ (NSString *)saveFile:(NSData *)data type:(NSString *)type Topath:(DirectoryType)path  withFilename:(NSString *)fileName;
+ (void)deleteFile:(NSString *)filePath;
+ (BOOL)deleteFile:(NSString *)fileName fromDirectory:(DirectoryType)directory;
+ (NSArray *)loadArrayFromPath:(DirectoryType)path withFilename:(NSString *)fileName;
+ (BOOL)saveArrayToPath:(DirectoryType)path withFilename:(NSString *)fileName array:(NSArray *)array;

@end
