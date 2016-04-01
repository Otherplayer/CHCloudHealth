//
//  ViewController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 3/29/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [[NetworkingManager sharedManager] registerWithMobile:@"18513149993" password:@"123455" captcha:@"12345" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        
    }];
    
//    [[HYQNetworkingManager sharedManager] getCaptchaWithMobile:@"18513149993" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
//        
//    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
