//
//  NSObject+Categories.h
//  HYQuan
//
//  Created by fqah on 12/10/15.
//  Copyright © 2015 fqah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Categories)
/// 为NSObject子类添加任何信息..associative机制
- (id)associatedObjectForKey:(NSString *)key;
- (void)setAssociatedObject:(id)object forKey:(NSString *)key;

@end
