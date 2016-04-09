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



@end

@implementation CMMessageCell

- (void)configureTitle:(NSString *)title detail:(NSString *)detail time:(NSString *)time{
    [self.labTitle setText:title];
    [self.labDetail setText:detail];
    [self.labTime setText:time];
}

- (void)configureTitle:(NSString *)title detail:(NSString *)detail time:(NSString *)time state:(NSInteger)state{
    [self.labTitle setText:title];
    [self.labDetail setText:detail];
    [self.labTime setText:time];
    if (state == 0) {
        [self.labState setText:@"当前状态：未绑定"];
    }else{
        [self.labState setText:@"当前状态：已绑定"];
        
    }
}

@end
