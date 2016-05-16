//
//  CHMainHeaderCell.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHMainHeaderCell.h"

@interface CHMainHeaderCell ()
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labMobile;
@property (weak, nonatomic) IBOutlet UIImageView *ivAvatar;

@property (weak, nonatomic) IBOutlet UILabel *labSOS;
@property (weak, nonatomic) IBOutlet UILabel *labLocation;
@property (weak, nonatomic) IBOutlet UILabel *labMedicine;

@property (weak, nonatomic) IBOutlet UILabel *labHeartRate;
@property (weak, nonatomic) IBOutlet UILabel *labReleationNum;
@property (weak, nonatomic) IBOutlet UILabel *labStep;

@end

@implementation CHMainHeaderCell

//familyNumCount = 0;
//heartRateAlarmCount = 0;
//locationAlarmCount = 0;
//medicationCount = 6;
//mobileNum = 172121123123;
//name = "\U706f\U706b\U9611\U73ca";
//sosAlarmCount = 2;
//totalMoveStepCount = 0;

- (void)configure:(NSDictionary *)info{
    NSString *name = info[@"name"];
    NSString *mobile = info[@"mobileNum"];
    NSString *sosAlarmCount = [NSString stringWithFormat:@"%@次",info[@"sosAlarmCount"]];
    NSString *locationAlarmCount = [NSString stringWithFormat:@"%@个",info[@"locationAlarmCount"]];
    NSString *medicationCount = [NSString stringWithFormat:@"%@个",info[@"medicationCount"]];
    NSString *heartRateAlarmCount = [NSString stringWithFormat:@"%@次",info[@"heartRateAlarmCount"]];
    NSString *familyNumCount = [NSString stringWithFormat:@"%@个",info[@"familyNumCount"]];
    NSString *totalMoveStepCount = [NSString stringWithFormat:@"%@步",info[@"totalMoveStepCount"]];
    NSInteger sex = [info[@"sex"] integerValue];
    
    [self.labName setText:name];
    [self.labMobile setText:mobile];
    
    [self.labSOS setText:sosAlarmCount];
    [self.labLocation setText:locationAlarmCount];
    [self.labMedicine setText:medicationCount];
    
    [self.labHeartRate setText:heartRateAlarmCount];
    [self.labReleationNum setText:familyNumCount];
    [self.labStep setText:totalMoveStepCount];
    
    if (sex == 1) {
        [self.ivAvatar setImage:[UIImage imageNamed:@"app_sex_m"]];
    }else{
        [self.ivAvatar setImage:[UIImage imageNamed:@"app_sex_f"]];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
