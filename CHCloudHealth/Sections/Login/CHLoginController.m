//
//  CHLoginController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHLoginController.h"

@interface CHLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *mobilTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *btnForgetPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnGetHelp;

@end

@implementation CHLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *ivMobile = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    [ivMobile setImage:[UIImage imageNamed:@"ios_icon_7"]];
    ivMobile.contentMode = UIViewContentModeCenter;
    
    self.mobilTextField.leftViewMode = UITextFieldViewModeAlways;
    self.mobilTextField.leftView = ivMobile;
    
    UIImageView *ivPsd = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    [ivPsd setImage:[UIImage imageNamed:@"ios_icon_2"]];
    ivPsd.contentMode = UIViewContentModeCenter;
    
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.leftView = ivPsd;
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillDisappear:animated];
}

#pragma mark - Action

- (IBAction)cancelAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginAction:(id)sender {
    
    NSString *mobile = [self.mobilTextField.text trimmingWhitespace];
    NSString *psd = [self.passwordTextField.text trimmingWhitespace];
    
    if ([self canGo] && [self check]) {
        [[NetworkingManager sharedManager] loginWithMobile:mobile password:psd completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            if (success) {
                
            }else{
                
            }
        }];
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hidenKeyboard];
}


#pragma mark - Private

- (BOOL)check{
    NSString *mobile = [self.mobilTextField.text trimmingWhitespace];
    NSString *psd = [self.passwordTextField.text trimmingWhitespace];
    
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
    
    return YES;
}









@end
