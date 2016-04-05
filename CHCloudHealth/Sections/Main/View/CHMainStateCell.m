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
    NSString *value = [NSString stringWithFormat:@"%@ %@",info[@"val"],[self unitWithType:info[@"typeCode"]]];
    [self.labTitle setText:title];
    [self.labState setText:state];
    [self.labDate setText:date];
    [self.labValue setAttributedText:[self fixColorText:value]];
    [self.labValue setAdjustsFontSizeToFitWidth:YES];
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
            return @"error";
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
