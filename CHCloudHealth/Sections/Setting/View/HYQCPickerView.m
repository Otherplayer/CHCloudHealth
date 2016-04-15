//
//   /\_/\
//   \_ _/
//    / \ not
//    \_/
//
//  Created by __无邪_ on 1/28/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "HYQCPickerView.h"

@interface HYQCPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong)UIPickerView *pickerView; //选择器

@property (nonatomic, strong)NSMutableArray *items;
@property (nonatomic, strong)UIView *containerView;

@end

@implementation HYQCPickerView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setFrame:[[UIScreen mainScreen] bounds]];
        [self drawSelfSubview];
        
        self.items = [[NSMutableArray alloc] init];
        
    }
    return self;
}


-(void)showInView:(UIView *)superView items:(NSArray *)items{
    [self.items removeAllObjects];
    
    [superView addSubview:self];
    [self setUpPickerView];
    [self setUpLine];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.containerView setFrame:[self normalViewFrame]];
    } completion:^(BOOL finished) {
    }];
    
    [self.items addObjectsFromArray:items];
    [self.pickerView reloadAllComponents];
    
}


#pragma mark - initView
-(void)drawSelfSubview{
    UIView *viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    [self addSubview:viewBack];
    [viewBack setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmissView)];
    [viewBack addGestureRecognizer:tap];
    
    
    self.containerView = [[UIView alloc] initWithFrame:[self hiddenViewFrame]];
    [self.containerView setBackgroundColor:[UIColor whiteColor]];
    [viewBack addSubview:self.containerView];
    
    [self setUpToolBar];
    
}


-(void)setUpToolBar{
    
    UIColor *titleColor = [UIColor darkGrayColor];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, 44)];
    UIButton *cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *okButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [okButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [okButton.titleLabel setTextColor:[UIColor colorFromHexRGB:@"#333333"]];
    [cancelButton setTitleColor:titleColor forState:UIControlStateNormal];
    [okButton setTitleColor:titleColor forState:UIControlStateNormal];
    okButton.bounds=CGRectMake(0,0,60,40);
    cancelButton.bounds=CGRectMake(0,0,50,40);
    //    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton addTarget:self action:@selector(dissmissView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cancelButtonItem=[[UIBarButtonItem alloc]initWithCustomView:cancelButton];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *okButtonItem=[[UIBarButtonItem alloc]initWithCustomView:okButton];
    
    toolBar.items = [NSArray arrayWithObjects:cancelButtonItem,flexibleSpace,okButtonItem, nil];
    [self.containerView addSubview:toolBar];
    
    
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, kMainWidth, 1)];
    [lineLabel setBackgroundColor:[UIColor defaultColor]];
    [self.containerView addSubview:lineLabel];
    
}


- (void)setUpLine{
    
    UIColor *bgColor = [UIColor grayColor];
    UILabel *upline = [[UILabel alloc] initWithFrame:CGRectMake(0, 134.5, kMainWidth, 0.5)];
    [upline setBackgroundColor:bgColor];
    [self.containerView addSubview:upline];
    
    UILabel *downLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 169, kMainWidth, 0.5)];
    [downLine setBackgroundColor:bgColor];
    [self.containerView addSubview:downLine];
    
}


////////////////////////
////////////////////////

- (void)setUpPickerView{
    if (!self.pickerView || ![self.pickerView isDescendantOfView:self.containerView]) {
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, kMainWidth, 216)];
        [self.containerView addSubview:self.pickerView];
        [self.pickerView setDataSource:self];
        [self.pickerView setDelegate:self];
    }
}

#pragma mark - Mission


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

#pragma mark - UIPickerViewDelegate && UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.items.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.items[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *items = self.items[component];
    return items[row];
}



#pragma mark - Action

- (void)okButtonAction{

    NSString *result = @"";
    
    for (int i = 0; i < self.items.count; i++) {
        NSInteger row = [self.pickerView selectedRowInComponent:i];
        NSArray *items = self.items[i];
        result = [result stringByAppendingString:items[row]];
        if (i != (self.items.count - 1)) {
            result = [result stringByAppendingString:@"-"];
        }
    }
    
    if (self.didClickedOkAction) {
        self.didClickedOkAction(result);
    }
    
    [self dissmissView];
}
- (void)dissmissView{
    [UIView animateWithDuration:0.25 animations:^{
        [self.containerView setFrame:[self hiddenViewFrame]];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (CGRect)normalViewFrame{
    return CGRectMake(0, kMainHeight - 260, kMainWidth, 260);
}
- (CGRect)hiddenViewFrame{
    return CGRectMake(0, kMainHeight, kMainWidth, 260);
}




@end
