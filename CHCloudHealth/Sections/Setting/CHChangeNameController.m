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
    
    [self addRightButton2NavWithTitle:@"保存"];
    
}

#pragma mark - Action

- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    
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
