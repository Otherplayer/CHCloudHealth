//
//  HYQDatePickerView.m
//  GGPickerView
//
//  Created by __无邪_ on 15/8/4.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "HYQDatePickerView.h"

@interface HYQDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong)UIDatePicker *datePickerView;//时间选择器
@property (nonatomic, strong)UIPickerView *pickerView; //选择器

@property (nonatomic, strong)NSMutableArray *items;
@property (nonatomic, strong)UIView *containerView;
@property (nonatomic, assign)BOOL isTimeOnly;

@end

@implementation HYQDatePickerView{
    NSString *dateString;
    NSString *timeString;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        [self setFrame:[[UIScreen mainScreen] bounds]];
        [self drawSelfSubview];
        
        self.items = [[NSMutableArray alloc] init];
        for (int i = 0; i < 24; i++) {
            [self.items addObject:[NSString stringWithFormat:@"%02d:00",i]];
        }
    }
    return self;
}

-(void)showInView:(UIView *)superView withSelectDate:(NSString *)strSelectDate timeOnly:(BOOL)timeOnly{
    [superView addSubview:self];
    self.isTimeOnly = timeOnly;
    [self setUpDatePickerView];
    [self setUpPickerView];
    [self setUpLine];
    
    
    if (!strSelectDate || strSelectDate.length == 0) {
        NSDate *now = [NSDate date];
//        NSDate *tomorrow = [now dateByAddingTimeInterval:3600 * 24];
//        strSelectDate = [NSDate stringFromDate:tomorrow formatter:@"yyyy-MM-dd HH:00"];
        strSelectDate = [NSDate stringFromDate:now formatter:@"yyyy-MM-dd HH:00"];
    }
    
    if (strSelectDate && strSelectDate.length > 0) {
        
        NSArray *dates = [strSelectDate componentsSeparatedByString:@" "];
        dateString = dates[0];
//        timeString = dates[1];
        NSDate *curDate = curDate = [NSDate dateFromString:dateString formatter:@"yyyy-MM-dd"];
        [self.datePickerView setDate:curDate animated:YES];
        
//        NSInteger index = [self.items indexOfObject:timeString];
//        if (!index) {
//            index = 0;
//        }
//        [self.pickerView selectRow:index inComponent:0 animated:YES];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.containerView setFrame:[self normalViewFrame]];
    }];

}
-(void)showInView:(UIView *)superView withSelectDate:(NSString *)strSelectDate{
    [self showInView:superView withSelectDate:strSelectDate timeOnly:NO];
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
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth(), 44)];
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
    UILabel *upline = [[UILabel alloc] initWithFrame:CGRectMake(0, 134.5, ScreenWidth(), 0.5)];
    [upline setBackgroundColor:bgColor];
    [self.containerView addSubview:upline];
    
    UILabel *downLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 169, ScreenWidth(), 0.5)];
    [downLine setBackgroundColor:bgColor];
    [self.containerView addSubview:downLine];

}


////////////////////////
////////////////////////
- (void)setUpDatePickerView{
    
    
    
    if (!self.datePickerView || ![self.datePickerView isDescendantOfView:self.containerView]) {
        CGFloat width = kMainWidth;//iphone5 240
        CGFloat x = 20;
        
//        x = ( ScreenWidth() - width - 40 ) / 2;
        x = 0;
        
        self.datePickerView = [[UIDatePicker alloc] init];
        [self.datePickerView setFrame:CGRectMake(x, 44, width, 216)];
        [self.datePickerView setDatePickerMode:UIDatePickerModeDate];
        if (!self.isTimeOnly) {
            [self.datePickerView setMinimumDate:[NSDate nextHour]];
        }
//        [self.datePickerView setTimeZone:[NSTimeZone systemTimeZone]];
        [self.datePickerView setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [self.datePickerView setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/beijing"]];
        [self.containerView addSubview:self.datePickerView];
        [self.datePickerView addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)setUpPickerView{
    
    if (!self.pickerView || ![self.pickerView isDescendantOfView:self.containerView]) {
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.datePickerView.frame.size.width + self.datePickerView.frame.origin.x - 40, 44, 80, 216)];
        [self.containerView addSubview:self.pickerView];
        [self.pickerView setDataSource:self];
        [self.pickerView setDelegate:self];
        [self.pickerView setHidden:YES];
    }
}


#pragma mark - Mission

- (void)datePickerValueChanged:(UIDatePicker *)sender{
    NSDate *select = [sender date];//获取被选中的时间
    NSString *dateAndTime = [NSDate stringFromDate:select formatter:@"yyyy-MM-dd"];
    
    if (self.isTimeOnly) {
        dateString = dateAndTime;
        NSLog(@"%@",dateAndTime);
        return;
    }
    NSLog(@"%@",dateAndTime);
    dateString = dateAndTime;
    
    NSDate *now = [NSDate date];//获取被选中的时间
    NSString *dateNow = [NSDate stringFromDate:now formatter:@"yyyy-MM-dd"];
    NSString *timeNow = [NSDate stringFromDate:now formatter:@"HH"];
    if ([dateString isEqualToString:dateNow]) {
        //如果日期相同时，判断下时间
        NSArray *timeArr = [timeString componentsSeparatedByString:@":"];
        NSString *selectedTime = timeArr[0];
        
        if ([timeNow intValue] >= [selectedTime intValue]) {
            NSLog(@"%@==%@",timeNow,selectedTime);
            NSInteger newRow = ([timeNow intValue] + 1) % 24;
            if (!self.isTimeOnly) {
                [self.pickerView selectRow:newRow inComponent:0 animated:YES];
            }
            timeString = self.items[newRow];
        }
    }

    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"------%@",self.items[row]);
    
    NSDate *now = [NSDate date];//获取被选中的时间
    NSString *dateNow = [NSDate stringFromDate:now formatter:@"yyyy-MM-dd"];
    NSString *timeNow = [NSDate stringFromDate:now formatter:@"HH"];
    if ([dateString isEqualToString:dateNow]) {
        //如果日期相同时，判断下时间
        NSArray *timeArr = [self.items[row] componentsSeparatedByString:@":"];
        NSString *selectedTime = timeArr[0];
        
        if ([timeNow intValue] >= [selectedTime intValue]) {
            NSLog(@"%@==%@",timeNow,selectedTime);
            NSInteger newRow = ([timeNow intValue] + 1) % 24;
            if (!self.isTimeOnly) {
                [self.pickerView selectRow:newRow inComponent:0 animated:YES];
            }
            timeString = self.items[newRow];
        }
    }else{
        timeString = self.items[row];
    }
    
}

#pragma mark - UIPickerViewDelegate && UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.items.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.items[row];
}



#pragma mark - Action

- (void)okButtonAction{
    if (self.didClickedOkAction) {
        if (self.isTimeOnly) {
            NSString *result = [NSString stringWithFormat:@"%@",dateString];
            NSLog(@"%@",result);
            self.didClickedOkAction(result);
        }else{
            NSString *result = [NSString stringWithFormat:@"%@ %@",dateString,timeString];
            NSLog(@"%@",result);
            self.didClickedOkAction(result);
        }
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
    return CGRectMake(0, ScreenHeight() - 260, ScreenWidth(), 260);
}
- (CGRect)hiddenViewFrame{
    return CGRectMake(0, ScreenHeight(), ScreenWidth(), 260);
}

#ifndef ScreenWidth
static inline CGFloat ScreenWidth(){
    return [UIScreen mainScreen].bounds.size.width;
}
#endif

#ifndef ScreenHeight
static inline CGFloat ScreenHeight(){
    return [UIScreen mainScreen].bounds.size.height;
}
#endif







@end
