//
//  CHLocationAreaController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/7.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHLocationAreaController.h"

@implementation CHLocationAreaController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
}




#pragma mark -

- (void)getDatas{
    
    [[NetworkingManager sharedManager] getHealthRecordInfo:@"deviceUserId" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        if (success) {
            
        }else{
            [HYQShowTip showTipTextOnly:errDesc dealy:2];
        }
    }];
    
}




@end
