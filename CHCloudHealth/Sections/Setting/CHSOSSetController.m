//
//  CHSOSSetController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHSOSSetController.h"

@interface CHSOSSetController ()

@property (weak, nonatomic) IBOutlet UITextField *num;

@end

@implementation CHSOSSetController
#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton];
    [self setTitle:@"SOS设置"];
    [self.view setBackgroundColor:[UIColor color_f2f2f2]];
    
    [self addRightButton2NavWithTitle:@"完成"];
    
    
    
    [self getDatas];
    
}


- (void)getDatas{
    
    if ([self canGo]) {
        
        [HYQShowTip showProgressWithText:@"" dealy:20];
        [[NetworkingManager sharedManager] getSOSSetting:[CHUser sharedInstance].deviceId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    NSString *num = responseData[@"data"];
                    if (num && num.length > 0) {
                        [self.num setText:num];
                    }
                    [HYQShowTip hideImmediately];
                }else{
                    
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
            });
        }];
    }
    
}





#pragma mark -

- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    if ([self.num.text isPureNumberString]) {
        [[NetworkingManager sharedManager] setSOSSetting:[CHUser sharedInstance].deviceId sosNum:self.num.text completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
            });
        }];
    }
}


@end
