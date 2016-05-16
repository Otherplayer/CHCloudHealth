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
    
    [self.sSwitch addTarget:self action:@selector(didChangeValueAction:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)didChangeValueAction:(UISwitch *)sswitch{
    if (self.didChangeValueBlock) {
        self.didChangeValueBlock(sswitch.isOn ? @"1" : @"0");
    }
    if (self.didChangeValueSwitchBlock) {
        self.didChangeValueSwitchBlock(sswitch.isOn ? @"1" : @"0",self);
    }
}

@end
