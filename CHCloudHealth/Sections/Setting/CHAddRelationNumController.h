//
//  CHAddRelationNumController.h
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/10.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHRootViewController.h"

@interface CHAddRelationNumController : CHRootViewController

@property (nonatomic, strong) NSDictionary *originalInfo;
@property (nonatomic, copy) void(^didAddReleationNumBlock)();

@end
