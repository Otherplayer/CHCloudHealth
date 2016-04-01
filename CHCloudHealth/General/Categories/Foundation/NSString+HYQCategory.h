//
//  NSString+HYQCategory.h
//  HotYQ
//
//  Created by __无邪_ on 15/6/3.
//  Copyright (c) 2015年 hotyq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HYQCategory)

- (NSURL *)url;
- (BOOL)isBlackString;
- (NSDictionary *)jsonInfo;

- (CGFloat)heightWithFont:(UIFont *)font size:(CGSize)size;
- (CGFloat)widthWithFont:(UIFont *)font size:(CGSize)size;


- (NSString *)dateStringFromTimestamp; //时间戳转换为时间
- (NSString *)notifationDateStringFromTimestamp;//时间戳转换为时间昨天带时分


- (NSArray *)searchRanges:(NSString *)target;//搜索字符串
- (NSArray *)searchNicknameRanges;//@与空格之间



- (NSArray *)searchStr:(NSString *)targetStr;//搜索字符串
- (NSArray *)searchStrStart:(unichar)startChar end:(unichar)endChar end:(unichar)endChar2;
- (NSArray *)searchStrStart:(unichar)startChar end:(unichar)endChar;
- (NSArray *)searchStrStart2:(NSString *)startChar end:(NSString *)endChar;
- (NSArray *)searchStrStart2:(NSString *)startChar end:(NSString *)endChar end:(NSString *)endChar2;

- (NSString *)uniteKey:(NSString *)string;
+ (NSString *)UUIDString;

- (BOOL)isPureNumberString;
- (BOOL)isMobileNumberString;
- (NSString *)trimmingWhitespace;
- (NSString *)trimmingWhitespaceAndNewlines;
- (NSString *)trimCharacterToToken;
- (NSString *)trimming:(NSString *)str;

+ (NSString *)convertDateFormatWithDateString:(NSString *)dateString format:(NSString *)format;


// 一个中文字符长度为1，两个英文单词长度为1，不到两个英文单词长度也为1
- (NSInteger)realLength;

-(BOOL)IsChinese ;
//截取名字
- (NSString*)subStringName;

@end
