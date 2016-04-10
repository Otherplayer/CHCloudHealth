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
    [self addLeftButton2NavWithTitle:@"取消"];
    [self addRightButton2NavWithTitle:@"完成"];
    
    
}

- (void)leftBarButtonPressed:(id)leftBarButtonPressed{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    
    
    if ([self check]) {
        [[NetworkingManager sharedManager] setFamliyNumber:[CHUser sharedInstance].deviceId name:self.tfName.text relation:self.tfRelation.text mobile:self.tfMobile.text address:self.tfAddress.text remark:self.tfRemark.text completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    
                    if (self.didAddReleationNumBlock) {
                        self.didAddReleationNumBlock();
                    }
                    
                    [self leftBarButtonPressed:nil];
                    
                }else{
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
            });
        }];
        
    }
    
    
}

- (BOOL)check{
    
    return YES;
}



@end
