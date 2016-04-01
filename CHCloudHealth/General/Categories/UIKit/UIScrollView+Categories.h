//
//  UIScrollView+Categories.h
//  GGRefreshTableView
//
//  Created by fqah on 12/8/15.
//  Copyright © 2015 fqah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Categories)

#pragma mark - 上拉加载，下拉刷新

- (void)addRefreshingHeader:(void (^)())refreshingBlock;
- (void)addRefreshingFooter:(void (^)())refreshingBlock;

- (void)beginRefreshing;//开始刷新

- (void)endRefreshing;//结束刷新
- (void)endRefreshingWithNoMoreData;//没有数据调用此方法


//- (void)endHeaderRefreshing;
//- (void)endFooterRefreshing;

- (void)removeRefreshingHeader;
- (void)removeRefreshingFooter;




@end
