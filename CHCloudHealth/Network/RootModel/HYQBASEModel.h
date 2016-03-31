//
//  HYQBASEModel.h
//  HotYQ
//
//  Created by __无邪_ on 15/10/10.
//  Copyright © 2015年 hotyq. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HYQBASEModel : JSONModel
@property (nonatomic, assign) NSInteger state_code;

@property (nonatomic, strong) id <Optional>data;       //数据

//@property (nonatomic, strong) NSString *description;//避免出现与iOS字段重名这样的问题
@property (nonatomic, strong) NSString <Optional>*desc;

@property (nonatomic, strong) NSString <Optional>*time_stamp;
@property (nonatomic, strong) NSString <Optional>*comment_count;

//+ (void)initKeyMapper;

@end
