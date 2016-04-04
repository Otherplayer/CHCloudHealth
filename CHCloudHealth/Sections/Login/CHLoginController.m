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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hidenKeyboard];
}




@end
