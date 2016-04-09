//
//  CHResetPsdStep1Controller.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHResetPsdStep1Controller.h"
#import "CHTextField.h"
#import "CHResetPsdStep2Controller.h"

@interface CHResetPsdStep1Controller ()
@property (weak, nonatomic) IBOutlet CHTextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@end

@implementation CHResetPsdStep1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackButton];

    self.view.backgroundColor = [UIColor color_f2f2f2];
}


#pragma mark - Action


- (IBAction)nextAction:(id)sender {
    
    NSString *mobile = [self.mobileTextField.text trimmingWhitespace];
    if ([mobile isPureNumberString]) {
        CHResetPsdStep2Controller *controller = (CHResetPsdStep2Controller *)[[UIStoryboard loginStoryboard] resetPsdStep2Controller];
        controller.mobileNum = mobile;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [HYQShowTip showTipTextOnly:@"手机号有误" dealy:2];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hidenKeyboard];
}





@end
