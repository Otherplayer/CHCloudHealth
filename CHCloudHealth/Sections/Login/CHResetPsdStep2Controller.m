//
//  CHResetPsdStep2Controller.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHResetPsdStep2Controller.h"

@implementation CHResetPsdStep2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackButton];
    
    
}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hidenKeyboard];
}



@end
