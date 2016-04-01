//
//  UIViewController+Handle.m
//  HotYQ
//
//  Created by gm on 15/5/26.
//  Copyright (c) 2015年 hotyq. All rights reserved.
//

#import "UIViewController+Handle.h"


#define kNavButtonHeight 35.f
#define kNavButtonWidth 54.f
#define kNavImageWidth 22.f

@implementation UIViewController (Handle)


#pragma mark - Public

- (void)addLeftButton2NavWithTitle:(NSString *)title{
    self.navigationItem.leftBarButtonItems = @[[self titleButton:title left:YES enabled:YES]];
}
- (void)addLeftButton2NavWithImageName:(NSString *)imageName{
    self.navigationItem.leftBarButtonItems = @[[self titleButtonWithImageName:imageName left:YES]];
}
- (void)addRightButton2NavWithTitle:(NSString *)title{
    self.navigationItem.rightBarButtonItems = @[[self titleButton:title left:NO enabled:YES]];
}
- (void)addRightButton2NavWithImageName:(NSString *)imageName{
    self.navigationItem.rightBarButtonItems = @[[self titleButtonWithImageName:imageName left:NO]];
}
- (void)addTwoRightButton2NavWithImageName:(NSString *)imageName imageName:(NSString *)imageName2 actionL:(SEL)action actionR:(SEL)actionRight{
    self.navigationItem.rightBarButtonItems = @[[self titleButtonWithImageName:imageName left:NO width:30 action:action],[self titleButtonWithImageName:imageName2 left:NO width:30 action:actionRight]];
}
- (void)addBackButton{
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItems = @[[self backButton]];
}

- (void)setRightButtonEnabled:(BOOL)flag{
    [self.navigationItem.rightBarButtonItem setEnabled:flag];
}
- (void)setLeftButtonEnabled:(BOOL)flag{
    [self.navigationItem.leftBarButtonItem setEnabled:flag];
}

#pragma mark - Configure
- (UIBarButtonItem *)backButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, kNavButtonWidth, kNavButtonHeight)];
    [button addTarget:self action:@selector(backBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (kNavButtonHeight - kNavImageWidth)/2, kNavImageWidth, kNavImageWidth)];
    [imageView setImage:[UIImage imageNamed:@"back"]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [button addSubview:imageView];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (UIBarButtonItem *)titleButton:(NSString *)title left:(BOOL)flag enabled:(BOOL)enabled{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, kNavButtonWidth, kNavButtonHeight)];
    if (flag) {
        [button setTag:555];
        [button addTarget:self action:@selector(leftBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [button setTag:556];
        [button addTarget:self action:@selector(rightBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor colorWithWhite:1 alpha:0.4] forState:UIControlStateDisabled];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button setEnabled:enabled];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (UIBarButtonItem *)titleButtonWithImageName:(NSString *)imageName left:(BOOL)flag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, kNavButtonWidth, kNavButtonHeight)];
    if (flag) {
        [button addTarget:self action:@selector(leftBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [button addTarget:self action:@selector(rightBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    CGFloat x = 0;
    CGFloat y = (kNavButtonHeight - kNavImageWidth)/2;
    if (flag) {
    }else{
        x = (kNavButtonWidth - kNavImageWidth);
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, kNavImageWidth, kNavImageWidth)];
    
    [imageView setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [button addSubview:imageView];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (UIBarButtonItem *)titleButtonWithImageName:(NSString *)imageName left:(BOOL)flag width:(CGFloat)width action:(SEL)selector{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, width, kNavButtonHeight)];
    if (flag) {
        [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }else{
        [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    CGFloat x = 0;
    CGFloat y = (kNavButtonHeight - kNavImageWidth)/2;
    if (flag) {
    }else{
        x = (width - kNavImageWidth);
        if (x < 0) {
            x = 0;
        }
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, kNavImageWidth, kNavImageWidth)];
    [imageView setImage:[UIImage imageNamed:imageName]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [button addSubview:imageView];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)backBarButtonPressed:(id)backBarButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftBarButtonPressed:(id)leftBarButtonPressed{
    
}
- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    
}


@end
