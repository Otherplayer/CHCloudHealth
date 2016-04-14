//
//  CHChangeNameController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 4/6/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "CHChangeNameController.h"
#import "CHTextField.h"

@interface CHChangeNameController ()
@property (weak, nonatomic) IBOutlet CHTextField *nameTextField;

@end

@implementation CHChangeNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self.view setBackgroundColor:[UIColor color_f2f2f2]];
    [self addRightButton2NavWithTitle:@"保存"];
    
    
    if (self.type == 1) {
        self.title = @"电话";
        self.nameTextField.placeholder = @"填写电话";
    }else{
        self.title = @"昵称";
        self.nameTextField.placeholder = @"填写昵称";
    }
    
}

#pragma mark - Action

- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    NSString *result = [self.nameTextField.text trimmingWhitespace];
    if (result && result.length > 0) {
        if (self.didEditSuccessBlock) {
            self.didEditSuccessBlock(result);
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
