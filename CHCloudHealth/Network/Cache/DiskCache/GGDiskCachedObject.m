//
//  GGDiskCachedObject.m
//  GGNetwoking
//
//  Created by __无邪_ on 15/10/4.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "GGDiskCachedObject.h"

@implementation GGDiskCachedObject

// Insert code here to add functionality to your managed object subclass

#pragma mark - public method

+ (instancetype)saveContent:(NSData *)content identifier:(NSString *)identifier{
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key = %@",identifier];
//    GGDiskCachedObject *cachedObject = [GGDiskCachedObject MR_findFirstWithPredicate:predicate];
//    if (cachedObject == nil) {
//        cachedObject = [GGDiskCachedObject MR_createEntity];
//        cachedObject.key = identifier;
//    }
//    cachedObject.content = content;
//    cachedObject.lastUpdateTime = [NSDate dateWithTimeIntervalSinceNow:0];
//    //save
//    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];// should save on currentthread ???
//    return cachedObject;
    return nil;
}

+ (instancetype)fetchCachedDataWithIdentifier:(NSString *)identifier{
//    GGDiskCachedObject *cachedObject = [GGDiskCachedObject MR_findFirstByAttribute:@"key" withValue:identifier];
//    return cachedObject;
    return nil;
}

+ (void)deleteCachedObjectWithIdentifier:(NSString *)identifier{
//    GGDiskCachedObject *cachedObject = [GGDiskCachedObject MR_findFirstByAttribute:@"key" withValue:identifier];
//    if (cachedObject) {
//        BOOL isDeleted = [cachedObject MR_deleteEntity];
//        NSLog(@"DELETE:[%d]",isDeleted);
//    }
}




@end
