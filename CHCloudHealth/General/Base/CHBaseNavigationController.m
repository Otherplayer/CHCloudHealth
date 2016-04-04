//
//  CHBaseNavigationController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHBaseNavigationController.h"
#import "UINavigationBar+Awesome.h"

@implementation CHBaseNavigationController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.navigationBar setTranslucent:YES];
    [self.navigationBar setBarStyle:UIBarStyleBlack];
    //    self.navigationBar.tintColor = [UIColor colorFromHexRGB:@"fc272c"];//防止出现……
    //    [self.navigationBar lt_setBackgroundColor:[UIColor colorWithRed:0.122 green:0.129 blue:0.141 alpha:0.95]];
    [self.navigationBar lt_setBackgroundColor:[UIColor defaultColor]];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationBar.tintColor = [UIColor clearColor];
}


@end
