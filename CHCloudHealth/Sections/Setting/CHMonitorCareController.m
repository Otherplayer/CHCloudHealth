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
                    NSDictionary *section1 = @{@"title":@"心率报警",@"value":[NSString stringWithFormat:@"%@",@(value)]};
                    [self.datas addObject:section1];
                    
                    
                    
                    
                    
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
                    NSInteger value = [info[@"heartRateSwitch"] isEmptyObject] ? 0 : 1;
                    NSDictionary *section1 = @{@"title":@"心率报警",@"value":[NSString stringWithFormat:@"%@",@(value)]};
                    [self.datas addObject:section1];
                    
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
                    NSInteger value = [info[@"heartRateSwitch"] isEmptyObject] ? 0 : 1;
                    NSDictionary *section1 = @{@"title":@"心率报警",@"value":[NSString stringWithFormat:@"%@",@(value)]};
                    [self.datas addObject:section1];
                    
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
    if (indexPath.section == 2 || indexPath.section == 0) {
        return 44;
    }
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *info = [self.datas objectAtIndex:indexPath.section];
    if (indexPath.section == 0){
        static NSString *IdentifierLocationHeaderCell = @"IdentifierLocationHeaderCell";
        CHSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierLocationHeaderCell forIndexPath:indexPath];
        [cell configureTitle:info[@"title"] state:[info[@"value"] integerValue]];
        return cell;
    }else if (indexPath.section == 2){
        static NSString *IdentifierLocationRadiusCell = @"IdentifierLocationRadiusCell";
        CHUnitCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierLocationRadiusCell forIndexPath:indexPath];
        return cell;
    }
    static NSString *IdentifierLocationMonitorCell = @"IdentifierLocationMonitorCell";
    CHMonitorCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierLocationMonitorCell forIndexPath:indexPath];
    return cell;
    
}

@end
