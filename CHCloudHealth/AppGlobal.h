//
//  AppGlobal.h
//  FQAHProject
//
//  Created by __无邪_ on 3/31/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#ifndef AppGlobal_h
#define AppGlobal_h



#import "FQAHCategoriesHeader.h"
#import <AFNetworking.h>
#import <MagicalRecord/MagicalRecord.h>
#import "NetworkingManager.h"

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////


#define kMainWidth [[UIScreen mainScreen] bounds].size.width
#define kMainHeight [[UIScreen mainScreen] bounds].size.height


#define IS_IPHONE4      ([UIScreen mainScreen].bounds.size.height == 480.0f)
#define IS_IPHONE5      ([UIScreen mainScreen].bounds.size.height == 568.0f)
#define IS_IPHONE6      ([UIScreen mainScreen].bounds.size.height == 667.0f)//375w
#define IS_IPHONE6_PLUS ([UIScreen mainScreen].bounds.size.height == 736.0f)//414w

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

#define WS(weakSelf)          __weak __typeof(&*self)weakSelf = self;

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////


#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NSLog(...)
#endif

#endif /* AppGlobal_h */
