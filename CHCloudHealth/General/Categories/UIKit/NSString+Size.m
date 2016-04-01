//
//  NSString+Size.m
//  HotYQ
//
//  Created by gm on 15/3/18.
//  Copyright (c) 2015年 hotyq. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)
- (CGFloat)heightWithWidth:(CGFloat)width font:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize.height;
}
- (CGFloat)heightWithWidth:(CGFloat)width font:(UIFont *)font lineLimit:(NSInteger)lineLimit{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    NSString *oneLine = @"hg";
    float oneLineHeight = [oneLine heightWithWidth:kMainWidth font:font];
    if (lineLimit != -1) {
        if (retSize.height > (oneLineHeight * lineLimit)) {
            return oneLineHeight*lineLimit;
        }else{
            return retSize.height;
        }
    }else{
        return retSize.height;
    }
}
- (CGFloat)widthWithHeight:(CGFloat)height font:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize.width;
}

- (CGSize)rectWithFontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize
{
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    
    NSDictionary* attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    
    labelSize.height=ceil(labelSize.height);
    
    labelSize.width=ceil(labelSize.width);
    
    return labelSize;
}
+ (NSString *)subCharacterSetWithCharactersInString:(NSString *)string{
    NSString *tempString = string;
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"\n"];
    
    tempString = [[tempString componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    return tempString;

}
+ (NSString *)subCharacterSetWithCharactersInString:(NSString *)string willDeleteStr:(NSString *)str{
    NSString *tempString = string;
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:str];
    
    tempString = [[tempString componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    return tempString;
    
}
+ (NSString *)subCharacterSetWithCharactersInString:(NSString *)string willDeleteStr:(NSString *)str replace:(NSString *)st{
    NSString *tempString = string;
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:str];
    
    tempString = [[tempString componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: st];
    return tempString;
    
}
- (CGFloat)heightWithWidth:(CGFloat)width font:(UIFont *)font maxHeight:(CGFloat)maxHeight
{
    return ([self heightWithWidth:width font:font] < maxHeight ? [self heightWithWidth:width font:font] :maxHeight);
}
- (CGFloat)widthWithHeight:(CGFloat)height font:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    return ([self widthWithHeight:height font:font] < maxWidth ? [self widthWithHeight:height font:font] : maxWidth);
}
@end
