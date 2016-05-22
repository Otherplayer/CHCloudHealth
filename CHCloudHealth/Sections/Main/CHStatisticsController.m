//
//  CHStatisticsController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/5.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHStatisticsController.h"
#import "JRGraphView.h"
#import "HYQDatePickerView.h"

@interface CHStatisticsController ()

@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *dataArrSecond;
@property (nonatomic, strong)NSMutableArray *originalDataArr;
@property (strong, nonatomic)NSString *selectedDate;

//@property (weak, nonatomic) IBOutlet JRGraphView *graphView;
@property (strong, nonatomic) JRGraphView *graphView;
@property (weak, nonatomic) IBOutlet UILabel *labFirst;
@property (weak, nonatomic) IBOutlet UILabel *labSecond;
@property (weak, nonatomic) IBOutlet UIButton *btnDate;



@end

@implementation CHStatisticsController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addBackButton];
    [self setFullScreenPopGestureDisabled:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.dataArr = [[NSMutableArray alloc] init];
    self.dataArrSecond = [[NSMutableArray alloc] init];
    self.originalDataArr = [[NSMutableArray alloc] init];
    
    
    self.selectedDate = [NSString stringWithFormat:@"%@",[[NSDate date] descriptionWithFormatter:@"yyyy-MM-dd"]];
    [self.btnDate setTitle:self.selectedDate forState:UIControlStateNormal];
    [self.btnDate setBackgroundColor:[UIColor defaultColor]];
    
    if (self.type == 2) {
        [self setTitle:@"心率统计"];
    }else if (self.type == 3){
        [self setTitle:@"血压统计"];
    }else if (self.type == 4){
        [self setTitle:@"血糖统计"];
    }
    
    [self getDatas];
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [HYQShowTip hideImmediately];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)showDateAction:(id)sender {
    WS(weakSelf);
    HYQDatePickerView *datePicker = [[HYQDatePickerView alloc] init];
    [datePicker setDidClickedOkAction:^(NSString *result) {
        weakSelf.selectedDate = result;
        [weakSelf.btnDate setTitle:result forState:UIControlStateNormal];
        
        [weakSelf getDatas];
        
        
    }];
    [datePicker showInView:self.view withSelectDate:self.selectedDate timeOnly:YES];
}

#pragma mark -

- (void)getDatas{
    
    [self.originalDataArr removeAllObjects];
    if (self.type == 2) {
        [HYQShowTip showProgressWithText:@"" dealy:30];
        [[NetworkingManager sharedManager] getHeartRateInfo:[CHUser sharedInstance].deviceUserId date:@"2016-05-18" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    
                    
                    
                    NSArray *results = responseData[@"data"];
                    
                    NSArray *newResults = [results sortedArrayUsingComparator:^NSComparisonResult(NSDictionary * obj1, NSDictionary *obj2) {
                        double tim1 = [obj1[@"createDate"] doubleValue];
                        double tim2 = [obj2[@"createDate"] doubleValue];
                        
                        return tim1 > tim2;
                    }];
                    
                    
                    
                    [self.originalDataArr addObjectsFromArray:newResults];
                    if (self.originalDataArr.count == 0) {
//                        [HYQShowTip showTipTextOnly:[NSString stringWithFormat:@"%@无记录",self.selectedDate] dealy:2];
                        [HYQShowTip showTipTextOnly:[NSString stringWithFormat:@"暂无数据"] dealy:4];
                    }else{
                        [HYQShowTip hideImmediately];
                    }
                    [self refreshGraph];
                }else{
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
            });
        }];
    }else if (self.type == 3){
        [HYQShowTip showProgressWithText:@"" dealy:30];
        [[NetworkingManager sharedManager] getBloodPressureInfo:[CHUser sharedInstance].deviceUserId date:self.selectedDate completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (success) {
                    
                    NSArray *results = responseData[@"data"];
                    
                    NSArray *newResults = [results sortedArrayUsingComparator:^NSComparisonResult(NSDictionary * obj1, NSDictionary *obj2) {
                        double tim1 = [obj1[@"createDate"] doubleValue];
                        double tim2 = [obj2[@"createDate"] doubleValue];
                        
                        return tim1 > tim2;
                    }];
                    
                    
                    
                    [self.originalDataArr addObjectsFromArray:newResults];
                    [self refreshGraph];
                    if (self.originalDataArr.count == 0) {
//                        [HYQShowTip showTipTextOnly:[NSString stringWithFormat:@"%@无记录",self.selectedDate] dealy:2];
                        [HYQShowTip showTipTextOnly:[NSString stringWithFormat:@"暂无数据"] dealy:4];
                    }else{
                        [HYQShowTip hideImmediately];
                    }
                }else{
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
            });
        }];
    }else if (self.type == 4){
        [HYQShowTip showProgressWithText:@"" dealy:30];
        [[NetworkingManager sharedManager] getBloodSugarInfo:[CHUser sharedInstance].deviceUserId date:self.selectedDate completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
           dispatch_async(dispatch_get_main_queue(), ^{
               
               if (success) {
                   
                   NSArray *results = responseData[@"data"];
                   
                   NSArray *newResults = [results sortedArrayUsingComparator:^NSComparisonResult(NSDictionary * obj1, NSDictionary *obj2) {
                       double tim1 = [obj1[@"createDate"] doubleValue];
                       double tim2 = [obj2[@"createDate"] doubleValue];
                       
                       return tim1 > tim2;
                   }];
                   
                   
                   
                   [self.originalDataArr addObjectsFromArray:newResults];
//                   [self.originalDataArr addObjectsFromArray:responseData[@"data"]];
                   [self refreshGraph];
                   if (self.originalDataArr.count == 0) {
//                       [HYQShowTip showTipTextOnly:[NSString stringWithFormat:@"%@无记录",self.selectedDate] dealy:2];
                       [HYQShowTip showTipTextOnly:[NSString stringWithFormat:@"暂无数据"] dealy:4];
                   }else{
                       [HYQShowTip hideImmediately];
                   }
               }else{
                   [HYQShowTip showTipTextOnly:errDesc dealy:2];
               }
           });
        }];
    }
    
}



- (void)refreshGraph{
    
    [self.dataArr removeAllObjects];
    
    if (self.originalDataArr.count == 0) {
        return;
    }
    
    
    self.graphView = [[JRGraphView alloc] initWithFrame:CGRectMake(0, 64, kMainWidth, kMainHeight - 150)];
    [self.view addSubview:self.graphView];
    
    
    if (self.type == 2) {
        for (int i = 0; i < self.originalDataArr.count; i++) {
            NSDictionary *info = self.originalDataArr[i];
            
            NSDate *date = [[NSDate date] dateFromUnixTimestamp:([info[@"createDate"] doubleValue] / 1000)];
            NSNumber *newX = [self parseDateToXAxisOffset:date];
            NSNumber *ys = @([info[@"val"] integerValue]);
            NSNumber *x = @(i);
//            NSNumber *y = @([info[@"val"] integerValue] + 60);
            [self.dataArr addObject:@{ X_AXIS: x, Y_AXIS: ys ,XXXXXXX :newX}];
        }
        
    }else if (self.type == 3){
        for (int i = 0; i < self.originalDataArr.count; i++) {
            NSDictionary *info = self.originalDataArr[i];
            NSNumber *x = @(i);
            
            NSDate *date = [[NSDate date] dateFromUnixTimestamp:([info[@"createDate"] doubleValue] / 1000)];
            NSLog(@"-----%@",date);
            NSNumber *newX = [self parseDateToXAxisOffset:date];
            
            NSNumber *y = @([info[@"diastolicPressures"] integerValue]);
            
            NSNumber *ys = @([info[@"systolicePressures"] integerValue]);
            
            [self.dataArr addObject:@{ X_AXIS: x, Y_AXIS: y ,XXXXXXX: newX}];
            [self.dataArrSecond addObject:@{ X_AXIS: x, Y_AXIS: ys ,XXXXXXX:newX}];
        }
    }else if (self.type == 4){
        for (int i = 0; i < self.originalDataArr.count; i++) {
            NSDictionary *info = self.originalDataArr[i];
            NSDate *date = [[NSDate date] dateFromUnixTimestamp:([info[@"createDate"] doubleValue] / 1000)];
            NSLog(@"-----%@",date);
            NSNumber *newX = [self parseDateToXAxisOffset:date];
            NSNumber *x = @(i);
            NSNumber *y = @([info[@"bloodGlucoseValue"] integerValue]);
            [self.dataArr addObject:@{ X_AXIS: x, Y_AXIS: y ,XXXXXXX: newX}];
        }
    }
    
    
    
//    for ( NSUInteger i = 0; i < 60; i++ ) {
//        NSNumber *x = @(i);
//        i = i + 1;
//        NSNumber *y = @((arc4random() % 120) + 41);
//        [self.dataArrSecond addObject:@{ X_AXIS: x, Y_AXIS: y ,XXXXXXX:@(1463615099000)}];
//    }
    
    [self.graphView.plotDatasDictionary setObject:self.dataArr forKey:kDataLine];
    [self.graphView.plotDatasDictionary setObject:self.dataArrSecond forKey:kDataLineSecond];
//    [self.graphView setLowerwarningValue:86];
//    [self.graphView setUpwarningValue:110];
    [self.graphView refresh];
}




 
 
 - (NSNumber *)parseDateToXAxisOffset:(NSDate *)date {
     NSTimeInterval timeIntervalSinceRef = [date timeIntervalSinceReferenceDate];
     return @(timeIntervalSinceRef);
 }
 
 




@end
