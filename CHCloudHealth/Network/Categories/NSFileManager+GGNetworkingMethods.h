//
//  NSFileManager+GGNetworkingMethods.h
//  GGNetwoking
//
//  Created by __无邪_ on 15/10/5.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (GGNetworkingMethods)
+ (long long)fileSizeAtPath:(NSString *)filePath;
@end
