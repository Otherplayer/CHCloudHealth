//
//  CHRelationShipController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHRelationShipController.h"

@interface CHRelationShipController ()
@property (weak, nonatomic) IBOutlet UITextField *num1;
@property (weak, nonatomic) IBOutlet UITextField *num2;
@property (weak, nonatomic) IBOutlet UITextField *num3;


@end

@implementation CHRelationShipController
#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton];
    [self.view setBackgroundColor:[UIColor color_f2f2f2]];
    
    [self addRightButton2NavWithTitle:@"完成"];
    
}



#pragma mark - 

- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    
}



@end
