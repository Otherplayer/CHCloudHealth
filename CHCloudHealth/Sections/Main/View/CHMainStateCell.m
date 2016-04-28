//
//  CHMainStateCell.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHMainStateCell.h"
#import "NSDate+HYQFormatter.h"

@interface CHMainStateCell ()

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labState;
@property (weak, nonatomic) IBOutlet UIImageView *ivAvatar;
@property (weak, nonatomic) IBOutlet UILabel *labDate;
@property (weak, nonatomic) IBOutlet UILabel *labValue;
@end

@implementation CHMainStateCell

//0001心率
//0002血压
//0003血糖
//0004位置
//0005健康
//typeCode

- (void)configure:(NSDictionary *)info{
    NSString *title = info[@"name"];
    NSString *date = [NSDate dateFromStr:[NSString stringWithFormat:@"%@",info[@"createDate"]]];
    NSString *state = [NSString stringWithFormat:@"%@",info[@"state"]];
    [self.labTitle setText:title];
    [self.labState setText:state];
    [self.labDate setText:date];
    
    NSString *type = info[@"typeCode"];
    [self.ivAvatar setImage:[UIImage imageNamed:[self imageWithType:type]]];
    if (type.integerValue < 4) {
        NSString *value = [NSString stringWithFormat:@"%@ %@",info[@"val"],[self unitWithType:type]];
        [self.labValue setAttributedText:[self fixColorText:value]];
        [self.labValue setAdjustsFontSizeToFitWidth:YES];
    }else{
        NSString *description = info[@"description"];
        [self.labValue setNumberOfLines:0];
        [self.labValue setLineBreakMode:NSLineBreakByWordWrapping];
        [self.labValue setText:[NSString stringWithFormat:@"%@",description]];
//        if ([type isEqualToString:@"0004"]) {
//            [self.labValue setText:@"北京西城区西直门"];
//        }else{
//            [self.labValue setText:@"点击查看历史体检报告"];
//        }
        [self.labValue setFont:[UIFont systemFontOfSize:20]];
    }
    
    if ([state containsString:@"正常"]) {
        [self.labState setTextColor:[UIColor color_66666]];
    }else{
        [self.labState setTextColor:[UIColor color_ca4341]];
    
    }
//    
//    if ([self isNormalWithType:type]) {
//    }else{
//    }
//    
}



- (NSString *)unitWithType:(NSString *)type{
    switch (type.integerValue) {
            case 1:
            return @"次/分钟";
            break;
            case 2:
            return @"mmHg";
            break;
            case 3:
            return @"mmol/L";
            break;
//            case 4:
//            return @"";
//            break;
//            case 5:
//            return @"";
//            break;
        default:
            return @"--";
            break;
    }
}

- (NSString *)imageWithType:(NSString *)type{
    switch (type.integerValue) {
        case 1:
            return @"ios_icon_5";
            break;
        case 2:
            return @"ios_icon_13";
            break;
        case 3:
            return @"ios_icon_20";
            break;
        case 4:
            return @"ios_icon_21";
            break;
        case 5:
            return @"ios_icon_22";
            break;
        default:
            return @"--";
            break;
    }
}

- (BOOL)isNormalWithType:(NSString *)type{
    switch (type.integerValue) {
        case 1:
            return YES;
            break;
        case 2:
            return YES;
            break;
        case 3:
            return NO;
            break;
        case 4:
            return YES;
            break;
        case 5:
            return NO;
            break;
        default:
            return YES;
            break;
    }
}



- (NSAttributedString *)fixColorText:(NSString *)value{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:value];
    NSRange valueRange = NSMakeRange(0, [value rangeOfString:@" "].location);
    NSRange unitRange = NSMakeRange(valueRange.length, value.length - valueRange.length);
    [attributedString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:50]} range:valueRange];
    [attributedString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} range:unitRange];
    
    return attributedString;
}


@end
