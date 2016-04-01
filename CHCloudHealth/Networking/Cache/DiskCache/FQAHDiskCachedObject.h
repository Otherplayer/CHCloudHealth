//
//  FQAHDiskCachedObject.h
//  
//
//  Created by __无邪_ on 4/1/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface FQAHDiskCachedObject : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
// Insert code here to declare functionality of your managed object subclass
+ (instancetype)saveContent:(NSData *)content identifier:(NSString *)identifier;

+ (instancetype)fetchCachedDataWithIdentifier:(NSString *)identifier;

+ (void)deleteCachedObjectWithIdentifier:(NSString *)identifier;


@end

NS_ASSUME_NONNULL_END

#import "FQAHDiskCachedObject+CoreDataProperties.h"
