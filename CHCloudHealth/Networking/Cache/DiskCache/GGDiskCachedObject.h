//
//  GGDiskCachedObject.h
//  GGNetwoking
//
//  Created by __无邪_ on 15/10/4.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface GGDiskCachedObject : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (instancetype)saveContent:(NSData *)content identifier:(NSString *)identifier;

+ (instancetype)fetchCachedDataWithIdentifier:(NSString *)identifier;

+ (void)deleteCachedObjectWithIdentifier:(NSString *)identifier;


@end

NS_ASSUME_NONNULL_END

#import "GGDiskCachedObject+CoreDataProperties.h"
