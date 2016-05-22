//
//  CHMainHeaderCell.h
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHMainHeaderCell : UITableViewCell

@property (nonatomic, copy)void(^didClickAvatarAction)();

- (void)configure:(NSDictionary *)info;

@end
