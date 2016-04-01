//
//  NSString+Size.h
//  HotYQ
//
//  Created by gm on 15/3/18.
//  Copyright (c) 2015年 hotyq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)
- (CGFloat)heightWithWidth:(CGFloat)width font:(UIFont *)font;
- (CGFloat)heightWithWidth:(CGFloat)width font:(UIFont *)font maxHeight:(CGFloat)maxHeight;
- (CGFloat)heightWithWidth:(CGFloat)width font:(UIFont *)font lineLimit:(NSInteger)lineLimit;
- (CGFloat)widthWithHeight:(CGFloat)height font:(UIFont *)font;
- (CGFloat)widthWithHeight:(CGFloat)height font:(UIFont *)font maxWidth:(CGFloat)maxWidth;
- (CGSize)rectWithFontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;
+ (NSString *)subCharacterSetWithCharactersInString:(NSString *)string;
///过滤字符串
+ (NSString *)subCharacterSetWithCharactersInString:(NSString *)string willDeleteStr:(NSString *)str;
+ (NSString *)subCharacterSetWithCharactersInString:(NSString *)string willDeleteStr:(NSString *)str replace:(NSString *)st;
@end
