//
//  CHAddRelationNumController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/10.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHAddRelationNumController.h"

@implementation CHAddRelationNumController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"添加亲情号码"];
    [self addLeftButton2NavWithTitle:@"取消"];
    [self addRightButton2NavWithTitle:@"完成"];
}

- (void)leftBarButtonPressed:(id)leftBarButtonPressed{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    if (self.didAddReleationNumBlock) {
        self.didAddReleationNumBlock();
    }
}


@end
