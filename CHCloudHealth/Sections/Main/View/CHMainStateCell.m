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


- (void)configure:(NSDictionary *)info{
    NSString *title = info[@"name"];
    NSLog(@"%@",info);
    NSString *date = [NSDate dateFromStr:[NSString stringWithFormat:@"%@",info[@"createDate"]]];
    NSString *state = [NSString stringWithFormat:@"%@",info[@"state"]];
    [self.labTitle setText:title];
    [self.labState setText:state];
    [self.labDate setText:date];
    
}


@end
