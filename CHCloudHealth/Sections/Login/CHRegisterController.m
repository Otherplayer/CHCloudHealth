//
//  CHRegisterController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHRegisterController.h"
#import "CHTextField.h"
#import "UIButton+countDown.h"

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
    
    self.view.backgroundColor = [UIColor color_f2f2f2];
    
//    self.mobileTextField.layer.borderColor = [UIColor color_f2f2f2].CGColor;
//    self.mobileTextField.layer.borderWidth = 1;
//    
//    self.passwordTextField.layer.borderColor = [UIColor color_f2f2f2].CGColor;
//    self.passwordTextField.layer.borderWidth = 1;
//    
//    self.captchaTextField.layer.borderColor = [UIColor color_f2f2f2].CGColor;
//    self.captchaTextField.layer.borderWidth = 1;
//    
    
    
    
    
}



#pragma mark - Action

- (IBAction)getCaptchaAction:(id)sender {
    
    if ([self canGo]) {
        NSString *mobile = [self.mobileTextField.text trimmingWhitespace];
        
        if (mobile && [mobile isMobileNumberString]) {
            [[NetworkingManager sharedManager] getCaptchaWithMobile:mobile type:@"register" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success) {
                        [self.btnGetCaptcha startTime:60 title:@"获取验证码" waitTittle:@"s"];
                    }else{
                        [HYQShowTip showTipTextOnly:errDesc dealy:2];
                    }
                });
            }];
        }else{
            [HYQShowTip showTipTextOnly:@"输入的手机号有误" dealy:2];
        }
    }
}

- (IBAction)registerAction:(id)sender {
    NSString *mobile = [self.mobileTextField.text trimmingWhitespace];
    NSString *psd = [self.passwordTextField.text trimmingWhitespace];
    NSString *captcha = [self.captchaTextField.text trimmingWhitespace];
    
    if ([self canGo] && [self check]) {
        [[NetworkingManager sharedManager] registerWithMobile:mobile password:psd captcha:captcha completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (success) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
                
            });
        }];
    }
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hidenKeyboard];
}


#pragma mark - Private

- (BOOL)check{
    NSString *mobile = [self.mobileTextField.text trimmingWhitespace];
    NSString *psd = [self.passwordTextField.text trimmingWhitespace];
    NSString *captcha = [self.captchaTextField.text trimmingWhitespace];
    
    if (!mobile || mobile.length == 0) {
        [HYQShowTip showTipTextOnly:@"请输入电话号码" dealy:2];
        return NO;
    }
    
    if (![mobile isMobileNumberString]) {
        [HYQShowTip showTipTextOnly:@"电话号码有误" dealy:2];
        return NO;
    }
    
    if (!psd || psd.length == 0) {
        [HYQShowTip showTipTextOnly:@"请输入密码" dealy:2];
        return NO;
    }
    
    if (!captcha || captcha.length == 0) {
        [HYQShowTip showTipTextOnly:@"请输入验证码" dealy:2];
        return NO;
    }
    
    return YES;
}



@end

