//
//  NSString+HYQCategory.m
//  HotYQ
//
//  Created by __无邪_ on 15/6/3.
//  Copyright (c) 2015年 hotyq. All rights reserved.
//

#import "NSString+HYQCategory.h"

@implementation NSString (HYQCategory)
- (NSURL *)url{
    return [NSURL URLWithString:self];
}
- (NSDictionary *)jsonInfo{
    NSError *error = nil;
    NSData *data = [self dataUsingEncoding:NSASCIIStringEncoding];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingAllowFragments
                                                                 error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }
    return nil;
}
- (CGFloat)heightWithFont:(UIFont *)font size:(CGSize)size{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName : font};
    
    CGFloat height = [self boundingRectWithSize:size options:options attributes:attributes context:nil].size.height;
//    if (height < 25) {
//        height = 25;
//    }
    
    return height;
}
- (CGFloat)widthWithFont:(UIFont *)font size:(CGSize)size{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName : font};
    
    CGFloat width = [self boundingRectWithSize:size options:options attributes:attributes context:nil].size.width;
    //    if (height < 25) {
    //        height = 25;
    //    }
    return width;
}
- (NSString *)uniteKey:(NSString *)string{
    return [NSString stringWithFormat:@"%@--%@",self,string];
}
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

//1.1分钟内显示刚刚
//2.大于1分钟小于1小时显示X分钟前
//3.大于1小时小于24小时都显示X小时前
//4.大于24小时但昨天00:00分后显示昨天
//5.早于昨天的显示月日时分  例如：5-3   15:30
//6.跨年显示年月日时分：  15-8-3  16:42
- (NSString *)dateStringFromTimestamp{
    NSDate *currentData = [NSDate date];
    NSTimeInterval time = [self doubleValue];
    NSTimeInterval seconds = [currentData timeIntervalSince1970] - time / 1000.0;
    
    NSString *tipString = @"";
    if (seconds < 60) {
        tipString = @"刚刚";
    }else if(seconds< 60 * 60){
        tipString = [NSString stringWithFormat:@"%ld分钟前",(long)(seconds / 60)];
    }else if (seconds < 60 * 60 * 24){
        tipString = [NSString stringWithFormat:@"%ld小时前",(long)(seconds / (60 * 60))];
    }else if(seconds < (3600 * 24 * 2 - 0)){
        tipString = @"昨天";
    }else{
        NSString *timeStr = [NSString stringWithFormat:@"%f",time];
        if (timeStr.length > 9) {
            time = time / 1000;
        }
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
        if ([confromTimesp isThisYear]) {
            tipString = FQAHStringFromDate(@"MM-dd HH:mm", confromTimesp);
        }else{
            tipString = FQAHStringFromDate(@"yy-MM-dd HH:mm", confromTimesp);
        }
    }
    return tipString;
}
- (NSString *)notifationDateStringFromTimestamp{
    NSDate *currentData = [NSDate date];
    NSTimeInterval time = [self doubleValue];
    NSTimeInterval seconds = [currentData timeIntervalSince1970] - time / 1000.0;
    
    NSString *tipString = @"";
    if (seconds < 60) {
        tipString = @"刚刚";
    }else if(seconds< 60 * 60){
        tipString = [NSString stringWithFormat:@"%ld分钟前",(long)(seconds / 60)];
    }else if (seconds < 60 * 60 * 24){
        tipString = [NSString stringWithFormat:@"%ld小时前",(long)(seconds / (60 * 60))];
    }else if(seconds < (3600 * 24 * 2 - 0)){
        NSString *timeStr = [NSString stringWithFormat:@"%f",time];
        if (timeStr.length > 9) {
            time = time / 1000;
        }
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
        tipString = [NSString stringWithFormat:@"昨天 %@",FQAHStringFromDate(@"HH:mm", confromTimesp)];
    }else{
        NSString *timeStr = [NSString stringWithFormat:@"%f",time];
        if (timeStr.length > 9) {
            time = time / 1000;
        }
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
        if ([confromTimesp isThisYear]) {
            tipString = FQAHStringFromDate(@"MM-dd HH:mm", confromTimesp);
        }else{
            tipString = FQAHStringFromDate(@"yy-MM-dd HH:mm", confromTimesp);
        }
    }
    return tipString;
}


- (NSArray *)searchStr:(NSString *)target{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:target options:0 error:&error];
    NSArray *results = [regex matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    
    if (error) {
        NSLog(@"ERROR:%@",error.debugDescription);
    }
    
    if (results) {
        //        for (NSTextCheckingResult *rs in results) {
        //            NSLog(@"%lu %lu",(unsigned long)rs.range.location,(unsigned long)rs.range.length);
        //        }
        return results;
    }
    
    return nil;
}

- (NSString *)searchStrStartIndex:(int)index start:(unichar)startChar end:(unichar)endChar end2:(unichar)endChar2{
    NSMutableArray *rangeArr = [[NSMutableArray alloc] init];
    NSRange range;
    BOOL isStart = YES;
    for (int i = index; i < self.length; i++) {
        char character = [self characterAtIndex:i];
        
        if (isStart && character == startChar) {
            range.location = i;
            isStart = NO;
        }
        if (!isStart && ((character == endChar) || character == endChar2)) {
            range.length = i - range.location;
            [rangeArr addObject:NSStringFromRange(range)];
            isStart = YES;
            break;
        }
    }
    if (!isStart){
        range.length = self.length - range.location;
        [rangeArr addObject:NSStringFromRange(range)];
    }
    if (range.location < self.length && range.length < self.length) {
        NSString *target = [self substringWithRange:NSMakeRange(range.location - 1, range.length)];
        return target;
    }
    
    return nil;
}
- (NSArray *)searchStrStart:(unichar)startChar end:(unichar)endChar end:(unichar)endChar2{
    NSMutableArray *rangeArr = [[NSMutableArray alloc] init];
    NSRange range;
    BOOL isStart = YES;
    for (int i = 0; i < self.length; i++) {
        char character = [self characterAtIndex:i];
        
        if (isStart && character == startChar) {
            range.location = i;
            isStart = NO;
        }
        if (!isStart && ((character == endChar) || (character == endChar2))) {
            range.length = i - range.location;
            [rangeArr addObject:NSStringFromRange(range)];
            isStart = YES;
        }
    }
//    if (isStart){
//        range.length = self.length - range.location;
//        [rangeArr addObject:NSStringFromRange(range)];
//    }
    return rangeArr;
}
- (NSArray *)searchStrStart:(unichar)startChar end:(unichar)endChar{
    NSMutableArray *rangeArr = [[NSMutableArray alloc] init];
    NSRange range;
    BOOL isStart = YES;
    for (int i = 0; i < self.length; i++) {
        char character = [self characterAtIndex:i];
        
        if (isStart && character == startChar) {
            range.location = i;
            isStart = NO;
        }
        if (!isStart && (character == endChar)) {
            range.length = i - range.location;
            [rangeArr addObject:NSStringFromRange(range)];
            isStart = YES;
        }
    }
//    if (!isStart){
//        range.length = self.length - range.location;
//        [rangeArr addObject:NSStringFromRange(range)];
//    }
    return rangeArr;
}
- (NSArray *)searchStrStart2:(NSString *)startChar end:(NSString *)endChar end:(NSString *)endChar2{
    NSMutableArray *rangeArr = [[NSMutableArray alloc] init];
    NSRange range;
    BOOL isStart = YES;
    for (int i = 0; i < self.length; i++) {
        NSString *character = [self stringAtIndex:i];
        
        if (isStart && [character isEqualToString:startChar]) {
            range.location = i;
            isStart = NO;
        }
        if (!isStart && (([character isEqualToString:endChar]) || ([character isEqualToString:endChar2]))) {
            range.length = i - range.location;
            [rangeArr addObject:NSStringFromRange(range)];
            isStart = YES;
        }
    }
    //    if (isStart){
    //        range.length = self.length - range.location;
    //        [rangeArr addObject:NSStringFromRange(range)];
    //    }
    return rangeArr;
}
- (NSArray *)searchStrStart2:(NSString *)startChar end:(NSString *)endChar{
    NSMutableArray *rangeArr = [[NSMutableArray alloc] init];
    NSRange range;
    BOOL isStart = YES;
    for (int i = 0; i < self.length; i++) {
        NSString *character = [self stringAtIndex:i];
        
        
        if (isStart && [character isEqualToString: startChar]) {
            range.location = i;
            isStart = NO;
        }
        if (!isStart && ([character isEqualToString: endChar])) {
            range.length = i - range.location;
            [rangeArr addObject:NSStringFromRange(range)];
            isStart = YES;
        }
    }
    //    if (!isStart){
    //        range.length = self.length - range.location;
    //        [rangeArr addObject:NSStringFromRange(range)];
    //    }
    return rangeArr;
}



- (NSArray *)searchRanges:(NSString *)target{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:target options:0 error:&error];
    NSAssert(regex, @"Regex failed: %@", error);
    NSArray *results = [regex matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    if (error) {
        NSLog(@"ERROR:%@",error.debugDescription);
    }
    
    NSMutableArray *ranges = [[NSMutableArray alloc] init];
    if (results) {
        for (NSTextCheckingResult *rs in results) {
            [ranges addObject:NSStringFromRange(rs.range)];
            //NSLog(@"%@",NSStringFromRange(rs.range));
        }
        return ranges;
    }
    return nil;
}

- (NSArray *)searchNicknameRanges{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"@([^\\ ]*) " options:0 error:&error];
    NSAssert(regex, @"Regex failed: %@", error);
    
    NSMutableArray *ranges = [[NSMutableArray alloc] init];
    [regex enumerateMatchesInString:self options:0 range:NSMakeRange(0, [self length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange range = [result rangeAtIndex:1];
        [ranges addObject:NSStringFromRange(NSMakeRange(range.location - 1, range.length + 1))];
        //        NSString *foundKey = [self substringWithRange:range];
        //        NSLog(@"foundKey = %@", foundKey);
    }];
    return ranges;
}


- (NSString *)stringAtIndex:(NSInteger)index{
    
    NSString *character;
    index ++;
    character = [self substringWithRange:NSMakeRange(index - 1, 1)];
    return character;
}

+ (NSString *)UUIDString {
    CFUUIDRef UUID = CFUUIDCreate(kCFAllocatorDefault);
    NSString *UUIDString = (__bridge_transfer NSString *) CFUUIDCreateString(kCFAllocatorDefault, UUID);
    CFRelease(UUID);
    // Remove '-' in UUID
    return [[[UUIDString componentsSeparatedByString:@"-"] componentsJoinedByString:@""] lowercaseString];
}
- (BOOL)isMobileNumberString{
    if (self.length == 11 && [self isPureNumberString]) {
        return YES;
    }
    return NO;
}
- (BOOL)isPureNumberString{
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0){
        return NO;
    }
    return YES;
}
- (NSString *)trimmingWhitespace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
- (NSString *)trimmingWhitespaceAndNewlines{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (NSString *)trimming:(NSString *)str{
    return [self stringByReplacingOccurrencesOfString:str withString:@""];
}

- (NSString *)trimCharacterToToken{
    return [[
             [self
              stringByReplacingOccurrencesOfString:@"<"
              withString:@""]
             stringByReplacingOccurrencesOfString:@">"
             withString:@""]
            stringByReplacingOccurrencesOfString:@" "
            withString:@""];
    
}

- (BOOL)isBlackString{
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)convertDateFormatWithDateString:(NSString *)dateString format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    double time = [dateString doubleValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    // 设置时区
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formater setTimeZone:timeZone];
    
    return [dateFormatter stringFromDate:date];
}

- (NSInteger)realLength{
    
    NSInteger strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0 ; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        }else {
            p++;
        }
    }
    return (strlength+1)/2;
    
}

//判断是否有中文
-(BOOL)IsChinese {
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

//截取名字
- (NSString*)subStringName{
    BOOL isChinese = [self IsChinese];
    if (isChinese&&self.length>10) {
        return   [self substringToIndex:8];
    }else if(!isChinese&&self.length>20){
        return   [self substringToIndex:15];
    }

    return self;
}
@end
