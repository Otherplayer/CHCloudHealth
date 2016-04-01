//
//  NSFileManager+SaveAndRead.m
//  HotYQ
//
//  Created by 王建 on 15/8/14.
//  Copyright (c) 2015年 hotyq. All rights reserved.
//

#import "NSFileManager+SaveAndRead.h"

@implementation NSFileManager (SaveAndRead)


+ (BOOL)saveHistoryArr:(NSString *)key path:(NSString *)path
{
    
    
    NSString *_path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:path];
    NSArray * array=  [NSArray arrayWithContentsOfFile:_path];//拿出数组
    NSMutableArray *_arr = [NSMutableArray arrayWithArray:array];

    if (_arr.count>=10) {
        [_arr removeLastObject];
    }
    NSArray *tempArr = [[NSArray alloc] initWithArray:_arr];
    for (NSString * text in tempArr) {
        if ([key isEqualToString:text]) {
            [_arr removeObject:key];
        }
    }
    [_arr insertObject:key atIndex:0];
   return  [_arr writeToFile:_path atomically:YES];
}
+ (NSString *)getPath:(DirectoryType)path
{
    NSString *_path;
    
    switch(path)
    {
        case DirectoryTypeMainBundle:
            _path = [self getBundlePathForFile:@""];
            break;
        case DirectoryTypeLibrary:
            _path = [self getLibraryDirectoryForFile:@""];
            break;
        case DirectoryTypeDocuments:
            _path = [self getDocumentsDirectoryForFile:@""];
            break;
        case DirectoryTypeCache:
            _path = [self getCacheDirectoryForFile:@""];
            break;
        default:
            break;
    }

    return _path;
}


+ (NSString *)saveFile:(NSData *)data type:(NSString *)type Topath:(DirectoryType)path  withFilename:(NSString *)fileName
{
    NSString *_path;
    
    switch(path)
    {
        case DirectoryTypeMainBundle:
            _path = [self getBundlePathForFile:fileName];
            break;
        case DirectoryTypeLibrary:
            _path = [self getLibraryDirectoryForFile:fileName];
            break;
        case DirectoryTypeDocuments:
            _path = [self getDocumentsDirectoryForFile:fileName];
            break;
        case DirectoryTypeCache:
            _path = [self getCacheDirectoryForFile:fileName];
            break;
        default:
            break;
    }
    
    
    NSLog(@"保持路径%@",_path);

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *filePath = _path;         //将图片存储到本地documents
    
    
    [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    
     [fileManager createFileAtPath:[filePath stringByAppendingString:[NSString stringWithFormat:@"/%fimage.%@",[[NSDate date] timeIntervalSince1970],type]] contents:  data attributes:nil];

    return _path;

}

+ (void)deleteFile:(NSString *)filePath {
    NSFileManager* fileManager=[NSFileManager defaultManager];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //文件名

    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (!blHave) {
        NSLog(@"no  have");
        return ;
    }else {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:filePath error:nil];
        if (blDele) {
            NSLog(@"删除成功dele success");
        }else {
            NSLog(@"dele fail");
        }
        
    }
}


+ (BOOL)saveArrayToPath:(DirectoryType)path withFilename:(NSString *)fileName array:(NSArray *)array
{
    NSString *_path;
    
    switch(path)
    {
        case DirectoryTypeMainBundle:
            _path = [self getBundlePathForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case DirectoryTypeLibrary:
            _path = [self getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case DirectoryTypeDocuments:
            _path = [self getDocumentsDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case DirectoryTypeCache:
            _path = [self getCacheDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        default:
            break;
    }
    
    NSLog(@"savedArrayToFile : %@",_path);
    return [NSKeyedArchiver archiveRootObject:array toFile:_path];
}

+ (NSArray *)loadArrayFromPath:(DirectoryType)path withFilename:(NSString *)fileName
{
    NSString *_path;
    
    switch(path)
    {
        case DirectoryTypeMainBundle:
            _path = [self getBundlePathForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case DirectoryTypeLibrary:
            _path = [self getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case DirectoryTypeDocuments:
            _path = [self getDocumentsDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case DirectoryTypeCache:
            _path = [self getCacheDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        default:
            break;
    }
    
    //NSLog(@"loadedArrayFromFile : %@",_path);
    return [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
}


+ (NSString *)getBundlePathForFile:(NSString *)fileName
{
    NSString *fileExtension = [fileName pathExtension];
    return [[NSBundle mainBundle] pathForResource:[fileName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", fileExtension] withString:@""] ofType:fileExtension];
}

+ (NSString *)getDocumentsDirectoryForFile:(NSString *)fileName
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", fileName]];
}

+ (NSString *)getLibraryDirectoryForFile:(NSString *)fileName
{
    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [libraryDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", fileName]];
}

+ (NSString *)getCacheDirectoryForFile:(NSString *)fileName
{
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [cacheDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", fileName]];
}



+ (BOOL)deleteFile:(NSString *)fileName fromDirectory:(DirectoryType)directory
{
    if(fileName.length > 0)
    {
        NSString *path;
        
        switch(directory)
        {
            case DirectoryTypeMainBundle:
                path = [self getBundlePathForFile:fileName];
                break;
            case DirectoryTypeLibrary:
                path = [self getLibraryDirectoryForFile:fileName];
                break;
            case DirectoryTypeDocuments:
                path = [self getDocumentsDirectoryForFile:fileName];
                break;
            case DirectoryTypeCache:
                path = [self getCacheDirectoryForFile:fileName];
                break;
            default:
                break;
        }
        
        if([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
        else
        {
            return NO;
        }
    }
    
    return NO;
}

@end
