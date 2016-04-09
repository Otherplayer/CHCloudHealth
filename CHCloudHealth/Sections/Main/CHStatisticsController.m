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

@property (weak, nonatomic) IBOutlet JRGraphView *graphView;



@end

@implementation CHStatisticsController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addBackButton];
    [self setFullScreenPopGestureDisabled:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.dataArr = [[NSMutableArray alloc] init];
    
    
    
    if (self.type == 1) {
        [self setTitle:@"心率统计"];
    }else if (self.type == 2){
        [self setTitle:@"血压统计"];
    }else if (self.type == 3){
        [self setTitle:@"血糖统计"];
    }
    
    
    
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
    
    [self getDatas];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark -

- (void)getDatas{
    
    if (self.type == 1) {
        [[NetworkingManager sharedManager] getHeartRateInfo:@"deviceUserId" date:@"2016-4-23" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            if (success) {
                
            }else{
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
        }];
    }else if (self.type == 2){
        [[NetworkingManager sharedManager] getHeartRateInfo:@"deviceUserId" date:@"2016-4-23" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            if (success) {
                
            }else{
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
        }];
    }else if (self.type == 3){
        [[NetworkingManager sharedManager] getHeartRateInfo:@"deviceUserId" date:@"2016-4-23" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            if (success) {
                
            }else{
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
        }];
    }
    
}















@end
