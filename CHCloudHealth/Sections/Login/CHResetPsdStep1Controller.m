//
//  CHResetPsdStep1Controller.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHResetPsdStep1Controller.h"

@interface CHResetPsdStep1Controller ()
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@end

@implementation CHResetPsdStep1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackButton];
    
    
}


#pragma mark - Action


- (IBAction)nextAction:(id)sender {
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hidenKeyboard];
}





@end
