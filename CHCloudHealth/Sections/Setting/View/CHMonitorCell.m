//
//  CHMonitorCell.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/7.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHMonitorCell.h"
#import "UIApplication+Categories.h"

@interface CHMonitorCell ()<UITextFieldDelegate>

@end

@implementation CHMonitorCell
- (void)setLeftTitle:(NSString *)leftTitle leftDetail:(NSString *)leftDetail title:(NSString *)title rightTitle:(NSString *)rightTitle rightDetail:(NSString *)rightDetail{

    [self.labLeftTitle setText:leftTitle];
//    [self.labLeftDetail setText:leftDetail];
    [self.tfLeftDetail setText:leftDetail];
    self.tfLeftDetail.delegate = self;
    [self.labTitle setText:title];
    [self.labRightTitle setText:rightTitle];
//    [self.labRightDetail setText:rightDetail];
    [self.tfRightDetail setText:rightDetail];
    self.tfRightDetail.delegate = self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIApplication hideKeyboard];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{        // return NO to disallow editing.
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{           // became first responder
    if (self.beginEditBlock) {
        self.beginEditBlock(YES);
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.beginEditBlock) {
        self.beginEditBlock(NO);
    }
    if ([textField isEqual:self.tfLeftDetail]) {
        if (self.leftDetailBlock) {
            self.leftDetailBlock(textField.text);
        }
    }else if ([textField isEqual:self.tfRightDetail]){
        if (self.rightDetailBlock) {
            self.rightDetailBlock(textField.text);
        }
    }
}




@end
