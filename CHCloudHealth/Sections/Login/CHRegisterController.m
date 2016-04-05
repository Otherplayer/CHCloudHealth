//
//  CHRegisterController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHRegisterController.h"
#import "CHTextField.h"

@interface CHRegisterController ()

@property (weak, nonatomic) IBOutlet CHTextField *mobileTextField;
@property (weak, nonatomic) IBOutlet CHTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet CHTextField *captchaTextField;
@property (weak, nonatomic) IBOutlet UIButton *btnGetCaptcha;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;




@end

@implementation CHRegisterController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackButton];
    
    
    
    self.mobileTextField.layer.borderColor = [UIColor color_f2f2f2].CGColor;
    self.mobileTextField.layer.borderWidth = 1;
    
    self.passwordTextField.layer.borderColor = [UIColor color_f2f2f2].CGColor;
    self.passwordTextField.layer.borderWidth = 1;
    
    self.captchaTextField.layer.borderColor = [UIColor color_f2f2f2].CGColor;
    self.captchaTextField.layer.borderWidth = 1;
    
    
    
    
    
}



#pragma mark - Action

- (IBAction)getCaptchaAction:(id)sender {
}

- (IBAction)registerAction:(id)sender {
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hidenKeyboard];
}

@end

