//
//  HYQBASEModel.h
//  HotYQ
//
//  Created by __无邪_ on 15/10/10.
//  Copyright © 2015年 hotyq. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BASEModel : JSONModel
@property (nonatomic, assign) NSInteger state_code;

@property (nonatomic, strong) id <Optional>data;       //数据
@property (nonatomic, strong) NSString *desc;

@property (nonatomic, strong) NSString *time_stamp;

//+ (void)initKeyMapper;

@end
