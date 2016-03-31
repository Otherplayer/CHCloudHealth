//
//  AppGlobal.h
//  GGNetwoking
//
//  Created by __无邪_ on 15/8/26.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#ifndef GGNetwoking_AppGlobal_h
#define GGNetwoking_AppGlobal_h

#import <AFNetworking/AFNetworking.h>
#import <MagicalRecord/MagicalRecord.h>
#import "HYQHelperReachibility.h"

#define NSLog(format, ...) do { \
fprintf(stderr, "<%s : %d> %s\n", \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
__LINE__, __func__); \
(NSLog)((format), ##__VA_ARGS__); \
fprintf(stderr, "------\n"); \
} while (0)


#define MR_CURRENTTHREAD_SAVE [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];



#endif
