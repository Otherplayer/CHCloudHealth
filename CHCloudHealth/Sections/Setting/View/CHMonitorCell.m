//
//  CHMonitorCell.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/7.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHMonitorCell.h"

@implementation CHMonitorCell
- (void)setLeftTitle:(NSString *)leftTitle leftDetail:(NSString *)leftDetail title:(NSString *)title rightTitle:(NSString *)rightTitle rightDetail:(NSString *)rightDetail{

    [self.labLeftTitle setText:leftTitle];
    [self.labLeftDetail setText:leftDetail];
    [self.labTitle setText:title];
    [self.labRightTitle setText:rightTitle];
    [self.labRightDetail setText:rightDetail];
    
    
}
@end
