//
//  DZNEmptyDataSetView.h
//  NZEmptySet
//
//  Created by __无邪_ on 16/2/19.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZNEmptyDataSetView : UIView
@property (nonatomic, readonly) UIView *contentView;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UILabel *detailLabel;
@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) UIButton *button;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@property (nonatomic, assign) CGFloat verticalOffset;
@property (nonatomic, assign) CGFloat verticalSpace;

@property (nonatomic, assign) BOOL fadeInOnDisplay;

- (void)setupConstraints;
- (void)prepareForReuse;



- (void)configureImage:(NSString *)imageName detail:(NSString *)detail button:(NSString *)btnTitle;

@end
