//
//  NSDate+HYQFormatter.m
//  GGPickerView
//
//  Created by __无邪_ on 15/8/5.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "NSDate+HYQFormatter.h"
@implementation NSDate (HYQFormatter)

//去时间戳
+ (NSString *)date1970
{

    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    return  [NSString stringWithFormat:@"%f", a];//转为字符型
    
    
}


+ (NSString *)getStrdate1970
{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    return  [NSString stringWithFormat:@"%.0f", ceil(a)];//转为字符型
    
    
}
- (NSDate*)dateFromUnixTimestamp:(NSTimeInterval)timestamp {
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}
+ (NSString *)dateFromStr:(NSString *)str
{
        NSString *_str = [NSString stringWithFormat:@"%@",str];
    if ([_str isEqualToString:@""] || !_str) {
        return @"";
    }

    if (_str.length < 13) {
        
        _str = [NSString stringWithFormat:@"%13f",[[NSDate date] timeIntervalSinceReferenceDate]];
    }
    _str  = [_str substringToIndex:10];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSTimeInterval timer  = [_str integerValue];

    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timer];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"confromTimespStr =  %@",confromTimespStr);
    return confromTimespStr;
}
+ (NSString *)dateMMSSFromStr:(NSString *)str
{
    NSString *_str = [NSString stringWithFormat:@"%@",str];
    if ([_str isEqualToString:@""] || !_str) {
        return @"";
    }
    
    if (_str.length < 13) {
        
        _str = [NSString stringWithFormat:@"%13f",[[NSDate date] timeIntervalSinceReferenceDate]];
    }
    _str  = [_str substringToIndex:10];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSTimeInterval timer  = [_str integerValue];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timer];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    NSLog(@"confromTimespStr =  %@",confromTimespStr);
    return confromTimespStr;
}

- (BOOL)isThisYear{
    NSString *yearStr = FQAHStringFromDate(@"yyyy", self);
    NSString *thisYear = FQAHStringFromDate(@"yyyy", [NSDate date]);
    if ([yearStr isEqualToString:thisYear]) {
        return YES;
    }
    return NO;
}

- (NSString *)yearString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    return [dateFormatter stringFromDate:self];
}
+ (NSDate *)dateFromString:(NSString *)string formatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *curDate = [dateFormatter dateFromString:string];
    
    return curDate;
}

+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter; //设置时间和日期的格式
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}


+ (NSDate *)tomorrow{
    return [[NSDate date] dateByAddingTimeInterval:3600 * 24];
}


+ (NSDate *)nextHour{
    return [[NSDate date] dateByAddingTimeInterval:3600];
}

- (NSString *)description{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss"; //设置时间和日期的格式
    NSString *dateString = [dateFormatter stringFromDate:self];
    return dateString;
}

@end
