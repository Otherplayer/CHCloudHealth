//
//  UITableView+Empty.m
//  JEmpty
//
//  Created by __无邪_ on 3/8/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "UITableView+Empty.h"
#import <objc/runtime.h>
@implementation UITableView (Empty)
static const BOOL loadingKey;
static const char loadedImageNameKey;
static const char descriptionTextKey;
static const char buttonTextKey;
static const char detailTextKey;////////
static const char buttonNormalColorKey;
static const char buttonHighlightColorKey;
static const CGFloat dataVerticalOffsetKey;

id (^block)();

#pragma mark set Mettod
-(void)setLoading:(BOOL)loading{
    if (self.loading == loading) {
        return;
    }
    if (loading == YES) {// 第一次的时候设置代理
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
    }
    
    objc_setAssociatedObject(self, &loadingKey, @(loading), OBJC_ASSOCIATION_ASSIGN);
    
    // 一定要放在后面，因为上面的代码在设值，要设置完之后数据源的判断条件才能成立
    
    if (![self isReachable]) {
        self.loading = NO;
    }
    
    if (loading == NO) {
        [self reloadEmptyDataSet];
    }else {
        __weak __typeof(&*self)weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakSelf.emptyDataSetVisible) {
                weakSelf.loading = NO;
            }
        });
    }
}
-(void)setLoadingClick:(void (^)())loadingClick{
    objc_setAssociatedObject(self, &block, loadingClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void)setLoadedImageName:(NSString *)loadedImageName{
    objc_setAssociatedObject(self, &loadedImageNameKey, loadedImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void)setDataVerticalOffset:(CGFloat)dataVerticalOffset{
    objc_setAssociatedObject(self, &dataVerticalOffsetKey,@(dataVerticalOffset),OBJC_ASSOCIATION_RETAIN);// 如果是对象，请用RETAIN。坑
}
-(void)setDescriptionText:(NSString *)descriptionText{
    objc_setAssociatedObject(self, &descriptionTextKey, descriptionText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void)setButtonText:(NSString *)buttonText{
    objc_setAssociatedObject(self, &buttonTextKey, buttonText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

///////////
-(void)setLabelDetailText:(NSString *)detailText{
 
    objc_setAssociatedObject(self, &detailTextKey, detailText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)setButtonNormalColor:(UIColor *)buttonNormalColor{
    objc_setAssociatedObject(self, &buttonNormalColorKey, buttonNormalColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)setButtonHighlightColor:(UIColor *)buttonHighlightColor{
    objc_setAssociatedObject(self, &buttonHighlightColorKey, buttonHighlightColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark get Mettod
- (BOOL)loading{
    id tmp = objc_getAssociatedObject(self, &loadingKey);
    NSNumber *number = tmp;
    return number.unsignedIntegerValue;
}
-(void (^)())loadingClick{
    return objc_getAssociatedObject(self, &block);
}
-(NSString *)loadedImageName{
    return objc_getAssociatedObject(self, &loadedImageNameKey);
}
-(CGFloat)dataVerticalOffset{
    id temp = objc_getAssociatedObject(self, &dataVerticalOffsetKey);
    NSNumber *number = temp;
    return number.floatValue;
}
-(NSString *)descriptionText{
    return objc_getAssociatedObject(self, &descriptionTextKey);
}
-(NSString *)buttonText{
    return objc_getAssociatedObject(self, &buttonTextKey);
}
////////////////
-(NSString *)labelText
{
    return objc_getAssociatedObject(self, &detailTextKey);
}
-(UIColor *)buttonNormalColor{
    return objc_getAssociatedObject(self, &buttonNormalColorKey);
}
-(UIColor *)buttonHighlightColor{
    return objc_getAssociatedObject(self, &buttonHighlightColorKey);
}
-(void)clickLoading:(loadingBlock)block{
    if (self.loadingClick) {
        block = self.loadingClick;
    }
    self.loadingClick = block;
}

#pragma mark - DZNEmptyDataSetSource
// 返回一个自定义的view（优先级最高）
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    if (![self isReachable]) {
        return nil;
    }else
    if (self.loading) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        return activityView;
    }else {
        return nil;
    }
}
// 返回一张空状态的图片在文字上面的
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (![self isReachable]) {
        return [UIImage imageNamed:@"ios_icon_17"];
    }else
    if (self.loading) {
        return nil;
    }else {
        NSString *imageName = @"ios_icon_17";
        if (self.loadedImageName) {
            imageName = self.loadedImageName;
        }
        return [UIImage imageNamed:imageName];
    }
}
// 返回空状态显示title文字，可以返回富文本
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
//{
//    if (self.loading) {
//        return nil;
//    }else {
//
//        NSString *text = @"没有数据";
//
//        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//        paragraph.alignment = NSTextAlignmentCenter;
//
//        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
//                                     NSForegroundColorAttributeName: [UIColor lightGrayColor],
//                                     NSParagraphStyleAttributeName: paragraph};
//
//        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//    }
//}
// 空状态下的文字详情
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    if (![self isReachable]) {
        NSString *text = @"没有网络!您可以尝试重新获取";
        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        paragraph.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                     NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                     NSParagraphStyleAttributeName: paragraph};
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }else
    if (self.loading) {
        return nil;
    }else {
        NSString *text = @"没有数据！";
        if (self.descriptionText) {
            text = self.descriptionText;
        }
        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        paragraph.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                     NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                     NSParagraphStyleAttributeName: paragraph};
        
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
}
// 返回最下面按钮上的文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    if (![self isReachable]) {
        UIColor *textColor = nil;
        // 某种状态下的颜色
        UIColor *colorOne = [UIColor whiteColor];
        UIColor *colorTow = [UIColor whiteColor];
        textColor = state == UIControlStateNormal ? colorOne : colorTow;
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                     NSForegroundColorAttributeName: textColor};
        
        return [[NSAttributedString alloc] initWithString:@"重新获取" attributes:attributes];
    }else
    if (self.loading) {
        return nil;
    }else {
        
        if (self.buttonText && self.buttonText.length > 0) {
            UIColor *textColor = nil;
            // 某种状态下的颜色
            UIColor *colorOne = [UIColor whiteColor];
            UIColor *colorTow = [UIColor whiteColor];
            // 判断外部是否有设置
            colorOne = self.buttonNormalColor ? self.buttonNormalColor : colorOne;
            colorTow = self.buttonHighlightColor ? self.buttonHighlightColor : colorTow;
            textColor = state == UIControlStateNormal ? colorOne : colorTow;
            NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                         NSForegroundColorAttributeName: textColor};
            return [[NSAttributedString alloc] initWithString:self.buttonText ? self.buttonText : @"再次刷新" attributes:attributes];
        }
        
        return nil;
    }
}
// 返回试图的垂直位置（调整整个试图的垂直位置）
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.dataVerticalOffset != 0) {
        return self.dataVerticalOffset;
    }
    return 0.0;
}
#pragma mark - DZNEmptyDataSetDelegate Methods
// 返回是否显示空状态的所有组件，默认:YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}
// 返回是否允许交互，默认:YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    // 只有非加载状态能交互
    return !self.loading;
}
// 返回是否允许滚动，默认:YES
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
// 返回是否允许空状态下的图片进行动画，默认:NO
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return YES;
}
//- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
//{
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
//    animation.duration = 0.25;
//    animation.cumulative = YES;
//    animation.repeatCount = MAXFLOAT;
//    
//    return animation;
//}
//  点击空状态下的view会调用
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    // 暂时不响应
    //    if (self.loadingClick) {
    //        self.loadingClick();
    //        [self reloadEmptyDataSet];
    //    }
}
// 点击空状态下的按钮会调用
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    if (self.loadingClick) {
        self.loadingClick();
        [self reloadEmptyDataSet];
    }
}

- (BOOL)isReachable{
    return [FQAHReachibility sharedInstance].isReachable;
}


@end
