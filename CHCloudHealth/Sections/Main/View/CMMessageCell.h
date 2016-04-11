//
//  CMMessageCell.h
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/9.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMMessageCell : UITableViewCell


- (void)configureTitle:(NSString *)title detail:(NSString *)detail time:(NSString *)time;
- (void)configureTitle:(NSString *)title detail:(NSString *)detail time:(NSString *)time state:(NSInteger)state;


@end
