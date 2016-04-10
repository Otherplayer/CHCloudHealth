//
//  CHSwitchCell.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/7.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHSwitchCell.h"

@implementation CHSwitchCell


- (void)configureTitle:(NSString *)title state:(NSInteger)state{
    [self.labTitle setText:title];
    [self.sSwitch setOn:state];
}

@end
