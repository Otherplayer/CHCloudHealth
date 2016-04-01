//
//  UIScrollView+Categories.m
//  GGRefreshTableView
//
//  Created by fqah on 12/8/15.
//  Copyright © 2015 fqah. All rights reserved.
//

#import "UIScrollView+Categories.h"
#import <MJRefresh.h>
@implementation UIScrollView (Categories)
- (void)addRefreshingHeader:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    
    if (!self.mj_header) {
        // 进入刷新状态后会自动调用这个block
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
        self.mj_header.automaticallyChangeAlpha = YES;
    }
}

- (void)addRefreshingFooter:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    
    if (!self.mj_footer) {
        // 进入刷新状态后会自动调用这个block
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:refreshingBlock];
    }
}

- (void)beginRefreshing{
    if (self.mj_header) {
        [self.mj_header beginRefreshing];
    }
}
- (void)endRefreshing{
    [self endHeaderRefreshing];
    [self endFooterRefreshing];
}

- (void)removeRefreshingHeader{
    if (self.mj_header) {
        [self.mj_header removeFromSuperview];
        self.mj_header = nil;
    }
}
- (void)removeRefreshingFooter{
    if (self.mj_footer) {
        [self.mj_footer removeFromSuperview];
        self.mj_footer = nil;
    }
}
- (void)endHeaderRefreshing{
    if (self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
    }
    [self resetNoMoreData];
}
- (void)endFooterRefreshing{
    if (self.mj_footer.isRefreshing) {
        [self.mj_footer endRefreshing];
    }
}
- (void)endRefreshingWithNoMoreData{
    if (self.mj_footer) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}
- (void)resetNoMoreData{
    if (self.mj_footer) {
        [self.mj_footer resetNoMoreData];
    }
}


@end
