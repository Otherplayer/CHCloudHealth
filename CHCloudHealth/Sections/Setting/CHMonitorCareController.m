//
//  CHMonitorCareController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHMonitorCareController.h"
#import "CHSwitchCell.h"
#import "CHUnitCell.h"
#import "CHMonitorCell.h"


typedef NS_ENUM(NSUInteger, CHCellType) {
    CHCellType_Switch,
    CHCellType_Unit,
    CHCellType_Monitor,
};

@interface CHMonitorCareController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@end


@implementation CHMonitorCareController
#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton];
    [self addRightButton2NavWithTitle:@"确认"];
    
    self.datas = [[NSMutableArray alloc] init];
    
    [self.tableView setBackgroundColor:[UIColor color_f2f2f2]];
    [self.tableView blankTableFooterView];
    [self getDatas];
    
    if (self.type == 3) {
        self.title = @"心率监测设置";
    }else if (self.type == 4){
        self.title = @"血糖监测设置";
    }else if (self.type == 5){
        self.title = @"血压监测设置";
    }
    
    
}

#pragma mark -

- (void)getDatas{
    if (self.type == 3) {//心率
        [[NetworkingManager sharedManager] getHeartRateSetting:[CHUser sharedInstance].deviceId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    
                    NSDictionary *info = responseData[@"data"];
                    NSInteger value = [info[@"heartRateSwitch"] isEmptyObject] ? 0 : 1;
                    NSDictionary *section1 = @{@"type":@(CHCellType_Switch),@"title":@"心率报警",@"value":[NSString stringWithFormat:@"%@",@(value)]};
                    [self.datas addObject:section1];
                    
                    
                    NSString *maxValue = @"";
                    NSString *minValue = @"";
                    if (![info[@"max"] isEmptyObject]) {
                        maxValue = [NSString stringWithFormat:@"%@",info[@"max"]];
                    }
                    if (![info[@"min"] isEmptyObject]) {
                        minValue = [NSString stringWithFormat:@"%@",info[@"min"]];
                    }
                    NSDictionary *section3 = @{@"type":@(CHCellType_Monitor),@"title":@"心率范围（bpm）",@"maxValue":maxValue,@"minValue":minValue,@"leftTitle":@"最低",@"rightTitle":@"最高"};
                    [self.datas addObject:section3];
                    
                    
                    NSString *time = @"";
                    if(![info[@"interval"] isEmptyObject]){
                        time = [NSString stringWithFormat:@"%@",info[@"interval"]];;
                    }
                    NSDictionary *section2 = @{@"type":@(CHCellType_Unit),@"title":@"提醒时间间隔",@"value":time};
                    [self.datas addObject:section2];
                    
                    
                    
                    self.tableView.loading = NO;
                    [self.tableView reloadData];
                }else{
                    self.tableView.loading = NO;
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
            });
            
        }];

    }else if (self.type == 4){//血糖
        [[NetworkingManager sharedManager] getBloodSugarSetting:[CHUser sharedInstance].deviceId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    
                    NSDictionary *info = responseData[@"data"];
                    NSInteger value = [info[@"bloodSugarSwitch"] isEmptyObject] ? 0 : 1;
                    NSDictionary *section1 = @{@"type":@(CHCellType_Switch),@"title":@"血糖监测",@"value":[NSString stringWithFormat:@"%@",@(value)]};
                    [self.datas addObject:section1];
                    
                    
                    NSString *maxValue = @"";
                    NSString *minValue = @"";
                    if (![info[@"maxBs"] isEmptyObject]) {
                        maxValue = [NSString stringWithFormat:@"%@",info[@"maxBs"]];
                    }
                    if (![info[@"minBs"] isEmptyObject]) {
                        minValue = [NSString stringWithFormat:@"%@",info[@"minBs"]];
                    }
                    NSDictionary *section3 = @{@"type":@(CHCellType_Monitor),@"title":@"血糖设置",@"maxValue":maxValue,@"minValue":minValue,@"leftTitle":@"起止",@"rightTitle":@"停止"};
                    [self.datas addObject:section3];
                    
                    
                    self.tableView.loading = NO;
                    [self.tableView reloadData];
                }else{
                    self.tableView.loading = NO;
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
            });
            
        }];
    }else if (self.type == 5){//血压
        [[NetworkingManager sharedManager] getBloodPressureSetting:[CHUser sharedInstance].deviceId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    
                    NSDictionary *info = responseData[@"data"];
                    NSInteger value = [info[@"bloodPressureSwitch"] isEmptyObject] ? 0 : 1;
                    NSDictionary *section1 = @{@"title":@"血压监测",@"value":[NSString stringWithFormat:@"%@",@(value)]};
                    [self.datas addObject:section1];
                    
                    
                    
                    NSString *maxLValue = @"";
                    NSString *minLValue = @"";
                    if (![info[@"maxLbp"] isEmptyObject]) {
                        maxLValue = [NSString stringWithFormat:@"%@",info[@"maxLbp"]];
                    }
                    if (![info[@"minLbp"] isEmptyObject]) {
                        minLValue = [NSString stringWithFormat:@"%@",info[@"minLbp"]];
                    }
                    NSDictionary *section2 = @{@"type":@(CHCellType_Monitor),@"title":@"血糖设置",@"maxValue":maxLValue,@"minValue":minLValue,@"leftTitle":@"起止",@"rightTitle":@"停止"};
                    [self.datas addObject:section2];
                    
                    
                    
                    NSString *maxValue = @"";
                    NSString *minValue = @"";
                    if (![info[@"maxHbp"] isEmptyObject]) {
                        maxValue = [NSString stringWithFormat:@"%@",info[@"maxHbp"]];
                    }
                    if (![info[@"minHbp"] isEmptyObject]) {
                        minValue = [NSString stringWithFormat:@"%@",info[@"minHbp"]];
                    }
                    NSDictionary *section3 = @{@"type":@(CHCellType_Monitor),@"title":@"血糖设置",@"maxValue":maxValue,@"minValue":minValue,@"leftTitle":@"起止",@"rightTitle":@"停止"};
                    [self.datas addObject:section3];
                    
                    
                    
                    
                    self.tableView.loading = NO;
                    [self.tableView reloadData];
                }else{
                    self.tableView.loading = NO;
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
            });
            
        }];
    }
}
- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    NSDictionary *section1 = [self.datas objectAtIndex:0];
    NSInteger state = [section1[@"value"] integerValue];
    
    if (self.type == 3) {//心率
        [[NetworkingManager sharedManager] setHeartRateSetting:[CHUser sharedInstance].deviceId heartRateSwitch:state completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    self.tableView.loading = NO;
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
            });
        }];
    }else if (self.type == 4){//血糖
        [[NetworkingManager sharedManager] setBloodSugarSetting:[CHUser sharedInstance].deviceId heartRateSwitch:state completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    self.tableView.loading = NO;
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
            });
        }];
    }else if (self.type == 5){//血压
        [[NetworkingManager sharedManager] setBloodPressureSetting:[CHUser sharedInstance].deviceId heartRateSwitch:state completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    self.tableView.loading = NO;
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
            });
        }];
    }
}

#pragma mark - Delegate
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainWidth, 10)];
    view.backgroundColor = [UIColor color_f2f2f2];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *info = [self.datas objectAtIndex:indexPath.section];
    NSInteger type = [info[@"type"] integerValue];
    
    if (type == CHCellType_Monitor) {
        return 150;
    }
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *info = [self.datas objectAtIndex:indexPath.section];
    NSInteger type = [info[@"type"] integerValue];
    if (type == CHCellType_Switch) {
        static NSString *IdentifierLocationHeaderCell = @"IdentifierLocationHeaderCell";
        CHSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierLocationHeaderCell forIndexPath:indexPath];
        [cell configureTitle:info[@"title"] state:[info[@"value"] integerValue]];
        return cell;
    }else if (type == CHCellType_Unit){
        static NSString *IdentifierLocationRadiusCell = @"IdentifierLocationRadiusCell";
        CHUnitCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierLocationRadiusCell forIndexPath:indexPath];
        [cell setTitle:info[@"title"] detail:info[@"value"]];
        return cell;
    }else if (type == CHCellType_Monitor){
        static NSString *IdentifierLocationMonitorCell = @"IdentifierLocationMonitorCell";
        CHMonitorCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierLocationMonitorCell forIndexPath:indexPath];
        [cell setLeftTitle:info[@"leftTitle"] leftDetail:info[@"minValue"] title:info[@"title"] rightTitle:info[@"rightTitle"] rightDetail:info[@"maxValue"]];
        return cell;
    }
    
    return nil;
}

@end
