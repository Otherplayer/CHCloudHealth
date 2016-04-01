//
//  UITableView+Categories.m
//  HotYQ
//
//  Created by fqah on 12/3/15.
//  Copyright © 2015 hotyq. All rights reserved.
//

#import "UITableView+Categories.h"

@implementation UITableView (Categories)
- (void)blankTableFooterView {
    [self setTableFooterView:[[UIView alloc] init]];
}

@end
