//
//  CHResetPsdStep2Controller.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHResetPsdStep2Controller.h"
#import "CHTextField.h"
#import "UIButton+countDown.h"

@interface CHResetPsdStep2Controller ()

@property (weak, nonatomic) IBOutlet CHTextField *captchaTextField;
@property (weak, nonatomic) IBOutlet UIButton *btnGetCaptcha;
@property (weak, nonatomic) IBOutlet CHTextField *psdTextField;
@property (weak, nonatomic) IBOutlet CHTextField *psdAgainTextField;


@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;

@end

@implementation CHResetPsdStep2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackButton];
    
    self.view.backgroundColor = [UIColor color_f2f2f2];
    
}


#pragma mark - Action

- (IBAction)confirmAction:(id)sender {
    
    if ([self check]) {
        NSString *psd = [self.psdTextField.text trimmingWhitespace];
        NSString *captcha = [self.captchaTextField.text trimmingWhitespace];
        [[NetworkingManager sharedManager] findBackPasswordWithMobile:self.mobileNum password:psd captcha:captcha completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    [HYQShowTip showTipTextOnly:@"设置密码成功" dealy:2];
                });
            }else{
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
        }];
    }
}
- (IBAction)getCaptchaAction:(id)sender {
    
    [[NetworkingManager sharedManager] getCaptchaWithMobile:self.mobileNum type:@"reset" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.btnGetCaptcha startTime:60 title:@"获取验证码" waitTittle:@"s"];
            });
        }else{
            [HYQShowTip showTipTextOnly:errDesc dealy:2];
        }
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hidenKeyboard];
}

#pragma mark - Private

- (BOOL)check{
    NSString *psd = [self.psdTextField.text trimmingWhitespace];
    NSString *psdAgain = [self.psdAgainTextField.text trimmingWhitespace];
    NSString *captcha = [self.captchaTextField.text trimmingWhitespace];
    
    
    if (!psd || psd.length == 0) {
        [HYQShowTip showTipTextOnly:@"请输入密码" dealy:2];
        return NO;
    }
    
    if (!captcha || captcha.length == 0) {
        [HYQShowTip showTipTextOnly:@"请输入验证码" dealy:2];
        return NO;
    }
    
    if (![psd isEqualToString:psdAgain]) {
        [HYQShowTip showTipTextOnly:@"两次密码输入不一样" dealy:2];
        return NO;
    }
    
    return YES;
}


@end
