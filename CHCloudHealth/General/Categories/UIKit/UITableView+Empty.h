//
//  UITableView+Empty.h
//  JEmpty
//
//  Created by __无邪_ on 3/8/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"
typedef void (^loadingBlock)();
@interface UITableView (Empty)<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, assign) BOOL loading;
@property (nonatomic, strong) NSString *loadedImageName;
@property (nonatomic, strong) NSString *descriptionText;// 空状态下的文字详情
@property (nonatomic, strong) NSString *buttonText;
@property (nonatomic, strong) UIColor *buttonNormalColor;// 按钮Normal状态下文字颜色
@property (nonatomic, strong) UIColor *buttonHighlightColor;// 按钮Highlight状态下文字颜色
@property (nonatomic, assign) CGFloat dataVerticalOffset;
@property(nonatomic,copy) loadingBlock loadingClick;// 点击回调block的属性

-(void)clickLoading:(loadingBlock)block;


@end
