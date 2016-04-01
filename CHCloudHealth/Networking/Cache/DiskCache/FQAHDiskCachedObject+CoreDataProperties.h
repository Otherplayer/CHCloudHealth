//
//  FQAHDiskCachedObject+CoreDataProperties.h
//  
//
//  Created by __无邪_ on 4/1/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FQAHDiskCachedObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FQAHDiskCachedObject (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *content;
@property (nullable, nonatomic, retain) NSString *key;
@property (nullable, nonatomic, retain) NSDate *lastUpdateTime;

@end

NS_ASSUME_NONNULL_END
