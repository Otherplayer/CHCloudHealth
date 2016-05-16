//
//  CMMessageCell.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/9.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CMMessageCell.h"


@interface CMMessageCell ()

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labDetail;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labState;
@property (weak, nonatomic) IBOutlet UIImageView *ivImage;



@end

@implementation CMMessageCell

- (void)configureTitle:(NSString *)title detail:(NSString *)detail time:(NSString *)time type:(NSInteger)type{
    [self.labTitle setText:title];
    [self.labDetail setText:detail];
    
    NSString *date = [NSDate dateFromStr:time];
    
    [self.labTime setText:date];
    
    
    if (type == 1) {
        [self.ivImage setImage:[UIImage imageNamed:@"ios_icon_14"]];
    }else if (type == 2){
        [self.ivImage setImage:[UIImage imageNamed:@"ios_icon_19"]];
    }else if (type == 3){
        [self.ivImage setImage:[UIImage imageNamed:@"ios_icon_22"]];
    }
    
    
    
}

- (void)configureTitle:(NSString *)title detail:(NSString *)detail name:(NSString *)name{
    [self.labTitle setText:title];
    [self.labDetail setText:detail];
    [self.labTime setText:name];
}


- (void)configureTitle:(NSString *)title detail:(NSString *)detail time:(NSString *)time state:(NSInteger)state{
    
    NSString *date = [NSString stringWithFormat:@"绑定时间：%@",[NSDate dateMMSSFromStr:time]];
    NSString *imei = [NSString stringWithFormat:@"IMEI：%@",detail];
    
    [self.labTitle setText:title];
    [self.labDetail setText:imei];
    [self.labTime setText:date];
    
    if (state == 0) {
        [self.labState setText:@"当前状态：未绑定"];
    }else{
        [self.labState setText:@"当前状态：已绑定"];
    }
}

@end
