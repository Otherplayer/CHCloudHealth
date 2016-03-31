//
//  NSDictionary+FQAHCategories.h
//  FQAHProject
//
//  Created by __无邪_ on 3/31/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FQAHCategories)
- (NSString *)urlParamsStringSignature:(BOOL)isForSignature;
- (NSString *)jsonString;
- (NSArray *)transformedUrlParamsArraySignature:(BOOL)isForSignature;
@end
