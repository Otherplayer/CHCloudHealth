//
//  NSDate+Ghost.m
//  __无邪_
//
//  Created by __无邪_ on 15/4/27.
//  Copyright (c) 2015年 __无邪_. All rights reserved.
//

#import "NSDate+Ghost.h"

@implementation NSDate (Ghost)
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)year
{
    return [[[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self] year];
}

- (NSString *)dateFormatter:(NSString *)formatter{
    if (!self) {
        return @"";
    }
    return SDStringFromDate(formatter, self);
}

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)month
{
    return [[[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:self] month];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)day
{
    return [[[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self] day];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)hour
{
    return [[[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:self] hour];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)minute
{
    return [[[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:self] minute];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)second
{
    return [[[NSCalendar currentCalendar] components:NSSecondCalendarUnit fromDate:self] second];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)week
{
    return [[[NSCalendar currentCalendar] components:NSWeekCalendarUnit fromDate:self] weekOfYear];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)weekday
{
    return [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:self] weekday];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)weekdayOrdinal
{
    return [[[NSCalendar currentCalendar] components:NSWeekdayOrdinalCalendarUnit fromDate:self] weekdayOrdinal];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSWeekOfMonthCalendarUnit fromDate:self] weekOfMonth];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSWeekOfYearCalendarUnit fromDate:self] weekOfYear];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSYearForWeekOfYearCalendarUnit fromDate:self] yearForWeekOfYear];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSInteger)quarter
{
    return [[[NSCalendar currentCalendar] components:NSQuarterCalendarUnit fromDate:self] quarter];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(BOOL)isLeapYear
{
    NSInteger year = [self year];
    return ((year%4 == 0 && year%100 != 0) || year%400 == 0);
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+(id)shortDateWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day Hour:(NSInteger)hour Minute:(NSInteger)minute Second:(NSInteger)second
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate * date = [calendar dateFromComponents:components];
    return date;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (NSString *)shortCutStringWithDateFormatter:(NSDateFormatter *)dateFormatter
{
    NSString * str = nil;
    if (!dateFormatter)
    {
        NSDateFormatter * dateFormatterDefault = [[NSDateFormatter alloc]init];
        [dateFormatterDefault setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        str = [dateFormatterDefault stringFromDate:self];
        str = [dateFormatter stringFromDate:self];
    }
    return str;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSString *)shortCutStringWithStrFormatter:(NSString *)strFormatter
{
    NSString * str = nil;
    if (!strFormatter)
    {
        strFormatter =@"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter * dateFormatterDefault = [[NSDateFormatter alloc]init];
    [dateFormatterDefault setDateFormat:strFormatter];
    str = [dateFormatterDefault stringFromDate:self];
    return str;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSString *)shortCutStringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateStyle:dateStyle];
    [outputFormatter setTimeStyle:timeStyle];
    NSString *outputString = [outputFormatter stringFromDate:self];
    return outputString;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+(NSDate *)shortCutDateWithString:(NSString *)dateStr dateFormatter:(NSDateFormatter *)dateFormatter
{
    NSDate * date = nil;
    if (!dateStr || !dateStr.length)
    {
        return nil;
    }
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    date = [dateFormatter dateFromString:dateStr];
    return date;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+(NSDate *)shortCutDateWithString:(NSString *)dateStr strFormatter:(NSString *)strFormatter
{
    NSDate * date = nil;
    if (!dateStr || !dateStr.length)
    {
        return nil;
    }
    
    if (!strFormatter.length ||!strFormatter)
    {
        strFormatter = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:strFormatter];
    date = [[self class] shortCutDateWithString:dateStr dateFormatter:dateFormatter];
    return date;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+(NSDate *)shortCutDateWithSince1970TimeMS:(long long)timeMSForSince1970
{
    return [NSDate dateWithTimeIntervalSince1970:timeMSForSince1970/1000];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSDate *)shortDateAfterMonth:(int)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterMonth;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSDate *)shortDateAfterDay:(int)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterDay;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSDate *)shortDateBeginningOfMonth
{
    return [self shortDateAfterDay:-(int)[self year] + 1];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSDate *)shortDateEndOfMonth
{
    return [[[self shortDateBeginningOfMonth] shortDateAfterMonth:1] shortDateAfterDay:-1];
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSDate *)shortDateEndOfWeek
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:(7 - [weekdayComponents weekday])];
    
    NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return endOfWeek;
}



///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(int)shortIndexWeekOfYear
{
    int i;
    NSUInteger year = [self year];
    NSDate * date = [self shortDateEndOfWeek];
    for (i = 1;[[date shortDateAfterDay:-7 * i] year] == year;i++)
    {
        
    }
    return i;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSUInteger)shortDaysAgoFromDate:(NSDate *)aDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:self
                                                 toDate:aDate
                                                options:0];
    return [components day];
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSUInteger)shortCountForWeekOfMonth
{
    return [[self shortDateEndOfMonth] shortIndexWeekOfYear] - [[self shortDateBeginningOfMonth] shortIndexWeekOfYear] + 1;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(NSUInteger)shortCountForDayOfMonth
{
    NSInteger nthMonth = [self month];
    NSInteger days[12] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    if ([self isLeapYear])
    {
        return nthMonth == 2 ? 29 : 28;
    }
    return days[nthMonth - 1];
}

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
+(NSUInteger)shortCountForDayOfMonth:(NSInteger)month OfYear:(NSInteger)year
{
    NSDate * date = [self shortDateWithYear:year Month:month Day:0 Hour:0 Minute:0 Second:0];
    return [date shortCountForDayOfMonth];;
}
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
- (NSString *)descriptionWithFormatter:(NSString *)formatter{
    return SDStringFromDate(formatter, self);
}

static inline NSString *SDStringFromDate(NSString *dateFormat, NSDate *date) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale systemLocale]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter stringFromDate:date];
}
@end
