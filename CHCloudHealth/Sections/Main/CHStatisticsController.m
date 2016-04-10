//
//  CHStatisticsController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/5.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHStatisticsController.h"
#import "JRGraphView.h"

@interface CHStatisticsController ()

@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *originalDataArr;

@property (weak, nonatomic) IBOutlet JRGraphView *graphView;
@property (weak, nonatomic) IBOutlet UILabel *labFirst;
@property (weak, nonatomic) IBOutlet UILabel *labSecond;



@end

@implementation CHStatisticsController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addBackButton];
    [self setFullScreenPopGestureDisabled:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.dataArr = [[NSMutableArray alloc] init];
    self.originalDataArr = [[NSMutableArray alloc] init];
    
    
    
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
    
    [self.graphView removeFromSuperview];
    self.graphView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark -

- (void)getDatas{
    
    if (self.type == 2) {
        [HYQShowTip showProgressWithText:@"" dealy:30];
        [[NetworkingManager sharedManager] getHeartRateInfo:@"222222" date:@"2016-04-09" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    [self.originalDataArr addObjectsFromArray:responseData[@"data"]];
                    [self refreshGraph];
                    [HYQShowTip hideImmediately];
                }else{
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
            });
        }];
    }else if (self.type == 3){
        [HYQShowTip showProgressWithText:@"" dealy:30];
        [[NetworkingManager sharedManager] getBloodPressureInfo:@"222222" date:@"2016-04-09" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            if (success) {
                [self.originalDataArr addObjectsFromArray:responseData[@"data"]];
                [self refreshGraph];
                [HYQShowTip hideImmediately];
            }else{
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
        }];
    }else if (self.type == 4){
        [HYQShowTip showProgressWithText:@"" dealy:30];
        [[NetworkingManager sharedManager] getBloodSugarInfo:@"222222" date:@"2016-04-09" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            if (success) {
                [self.originalDataArr addObjectsFromArray:responseData[@"data"]];
                [self refreshGraph];
                [HYQShowTip hideImmediately];
            }else{
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
        }];
    }
    
}



- (void)refreshGraph{
    
//    for (int i = 0; i < self.originalDataArr.count; i++) {
//        NSDictionary *info = self.originalDataArr[i];
//        NSNumber *x = @(i);
//        NSNumber *y = @([info[@"val"] integerValue] + 60);
//        [self.dataArr addObject:@{ X_AXIS: x, Y_AXIS: y }];
//    }
//    
    
    for ( NSUInteger i = 0; i < 60; i++ ) {
        NSNumber *x = @(i);
        i = i + 1;
        NSNumber *y = @((arc4random() % 120) + 41);
        [self.dataArr addObject:@{ X_AXIS: x, Y_AXIS: y }];
    }
    
    [self.graphView.plotDatasDictionary setObject:self.dataArr forKey:kDataLine];
    [self.graphView setLowerwarningValue:86];
    [self.graphView setUpwarningValue:110];
    [self.graphView refresh];
}











@end
