//
//  CHBindController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 4/6/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "CHBindController.h"
#import "CHTextField.h"

@interface CHBindController ()
@property (weak, nonatomic) IBOutlet CHTextField *numTextField;

@end

@implementation CHBindController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addLeftButton2NavWithImageName:@"ios_icon_4"];
    [self.view setBackgroundColor:[UIColor color_f2f2f2]];
    
    [self addRightButton2NavWithTitle:@"确定"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarButtonPressed:(id)leftBarButtonPressed{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    if ([self canGo]) {
        NSString *deviceNumber = [self.numTextField.text trimmingWhitespace];
        [[NetworkingManager sharedManager] bindDevice:[CHUser sharedInstance].uid number:deviceNumber completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            if (success) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
        }];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
