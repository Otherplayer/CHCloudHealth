//
//  CHResetPsdStep2Controller.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHResetPsdStep2Controller.h"

@interface CHResetPsdStep2Controller ()
@property (weak, nonatomic) IBOutlet UITextField *captchaTextField;
@property (weak, nonatomic) IBOutlet UIButton *btnGetCaptcha;
@property (weak, nonatomic) IBOutlet UITextField *psdTextField;
@property (weak, nonatomic) IBOutlet UITextField *psdAgainTextField;


@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;

@end

@implementation CHResetPsdStep2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackButton];
    
    
}


#pragma mark - Action

- (IBAction)confirmAction:(id)sender {
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hidenKeyboard];
}



@end
