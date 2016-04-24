//
//  CHAddRelationNumController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/10.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHAddRelationNumController.h"
#import "CHTextField.h"

@interface CHAddRelationNumController ()
@property (weak, nonatomic) IBOutlet CHTextField *tfName;
@property (weak, nonatomic) IBOutlet CHTextField *tfRelation;
@property (weak, nonatomic) IBOutlet CHTextField *tfMobile;
@property (weak, nonatomic) IBOutlet CHTextField *tfAddress;
@property (weak, nonatomic) IBOutlet CHTextField *tfRemark;


@end

@implementation CHAddRelationNumController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"添加亲情号码"];
    [self.view setBackgroundColor:[UIColor color_f2f2f2]];
//    [self addLeftButton2NavWithTitle:@"取消"];
    [self addBackButton];
    [self addRightButton2NavWithTitle:@"完成"];
    
    
//    if (self.originalInfo) {
//        [self.tfName setText:self.originalInfo[@"name"]];
//        [self.tfRelation setText:self.originalInfo[@"relation"]];
//        [self.tfMobile setText:self.originalInfo[@"mobile"]];
//    }
    
    
    [self getDatas];
}


- (void)getDatas{
    
    [[NetworkingManager sharedManager] getListFamliyNumber:[CHUser sharedInstance].deviceUserId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                
                NSArray *datas = responseData[@"data"];
                
                
                for (int i = 0; i < datas.count; i++) {
                    NSDictionary *info = datas[i];
                    NSString *mobile = info[@"mobile"];
                    if (i == 0) {
                        [self.tfName setText:mobile];
                    }else if (i == 1){
                        [self.tfRelation setText:mobile];
                    }else if (i == 2){
                        [self.tfMobile setText:mobile];
                    }else if (i == 3){
                        [self.tfAddress setText:mobile];
                    }
                    
                }
                
                
            }else{
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
        });
        
    }];
    
}


- (void)leftBarButtonPressed:(id)leftBarButtonPressed{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    
    
    if ([self check]) {
        
        
        NSString *num1 = [self.tfName.text trimmingWhitespace];
        NSString *num2 = [self.tfRelation.text trimmingWhitespace];
        NSString *num3 = [self.tfMobile.text trimmingWhitespace];
        NSString *num4 = [self.tfAddress.text trimmingWhitespace];
        
        [[NetworkingManager sharedManager] setFamliyNumber:[CHUser sharedInstance].deviceUserId num1:num1 num2:num2 num3:num3 num4:num4 completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            if (success) {
                [HYQShowTip showTipTextOnly:@"设置成功" dealy:2];
            }else{
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
        }];
        
//        [[NetworkingManager sharedManager] setFamliyNumber:[CHUser sharedInstance].deviceUserId name:self.tfName.text relation:self.tfRelation.text mobile:self.tfMobile.text address:self.tfAddress.text remark:self.tfRemark.text completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (success) {
//                    
//                    if (self.didAddReleationNumBlock) {
//                        self.didAddReleationNumBlock();
//                    }
//                    
//                    [self leftBarButtonPressed:nil];
//                    
//                }else{
//                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
//                }
//            });
//        }];
        
    }
    
    
}

- (BOOL)check{
    
    if ([self.tfName.text isEmptyObject]) {
        [HYQShowTip showTipTextOnly:@"名字不能为空" dealy:2];
        return NO;
    }
    if ([self.tfRelation.text isEmptyObject]) {
        [HYQShowTip showTipTextOnly:@"关系不能为空" dealy:2];
        return NO;
    }
    if ([self.tfMobile.text isEmptyObject]) {
        [HYQShowTip showTipTextOnly:@"电话不能为空" dealy:2];
        return NO;
    }
//    if ([self.tfAddress.text isEmptyObject]) {
//        [HYQShowTip showTipTextOnly:@"地址不能为空" dealy:2];
//        return NO;
//    }
//    if ([self.tfRemark.text isEmptyObject]) {
//        [HYQShowTip showTipTextOnly:@"备注不能为空" dealy:2];
//        return NO;
//    }
    
    return YES;
}



@end
