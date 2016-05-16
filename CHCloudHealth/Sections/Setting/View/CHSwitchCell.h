//
//  CHSwitchCell.h
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/7.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHSwitchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UISwitch *sSwitch;

@property (nonatomic, copy) void(^didChangeValueBlock)(NSString *isOn);
@property (nonatomic, copy) void(^didChangeValueSwitchBlock)(NSString *isOn,CHSwitchCell *selfCell);
- (void)configureTitle:(NSString *)title state:(NSInteger)state;

@end
