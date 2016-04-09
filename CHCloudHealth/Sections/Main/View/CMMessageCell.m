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



@end

@implementation CMMessageCell

- (void)configureTitle:(NSString *)title detail:(NSString *)detail time:(NSString *)time{
    [self.labTitle setText:title];
    [self.labDetail setText:detail];
    [self.labTime setText:time];
}

@end
