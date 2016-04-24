//
//  CHLocationMonitorController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHLocationMonitorController.h"
#import "CHSwitchCell.h"
#import "CHUnitCell.h"
#import "CHMonitorCell.h"
#import "CHSetTimeIntervalController.h"

@interface CHLocationMonitorController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@end


@implementation CHLocationMonitorController
#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton];
    [self addRightButton2NavWithTitle:@"确认"];
    
    self.datas = [[NSMutableArray alloc] init];
    
    [self.tableView setBackgroundColor:[UIColor color_f2f2f2]];
    [self.tableView blankTableFooterView];
    [self getDatas];
    
    
}

#pragma mark -

- (void)getDatas{
    [HYQShowTip showProgressWithText:@"" dealy:30];
    [[NetworkingManager sharedManager] getLocationSetting:[CHUser sharedInstance].deviceId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                
                NSDictionary *info = responseData[@"data"];
                NSDictionary *section1 = @{@"title":@"电子围栏",@"value":[NSString stringWithFormat:@"%@",info[@"locationSwitch"]]};
                [self.datas addObject:section1];
                
                
//                NSDictionary *section2 = @{@"title":@"围栏半径",@"value":[NSString stringWithFormat:@"%@",info[@"locationSwitch"]]};
//                [self.datas addObject:section1];
                NSString *time = @"";
                if(![info[@"interval"] isEmptyObject]){
                    time = [NSString stringWithFormat:@"%@分钟",info[@"interval"]];
                }
                NSDictionary *section2 = @{@"title":@"时间间隔",@"value":time};
                [self.datas addObject:section2];
                
                
                
                self.tableView.loading = NO;
                [self.tableView reloadData];
                
                [HYQShowTip hideImmediately];
                
            }else{
                self.tableView.loading = NO;
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
        });
        
    }];
    
}
- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    
    NSDictionary *section1 = [self.datas objectAtIndex:0];
    NSInteger state = [section1[@"value"] integerValue];
    NSDictionary *section2 = [self.datas objectAtIndex:1];
    
    NSLog(@"%@",section2[@"value"]);
    [[NetworkingManager sharedManager] setLocationSetting:[CHUser sharedInstance].deviceId locationSwitch:state interval:section2[@"value"] completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
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
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *info = [self.datas objectAtIndex:indexPath.section];
    if (indexPath.section == 0){
        static NSString *IdentifierLocationHeaderCell = @"IdentifierLocationHeaderCell";
        CHSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierLocationHeaderCell forIndexPath:indexPath];
        WS(weakSelf);
        [cell configureTitle:info[@"title"] state:[info[@"value"] integerValue]];
        [cell setDidChangeValueBlock:^(NSString *isOn) {
            NSDictionary *section1 = @{@"title":@"电子围栏",@"value":[NSString stringWithFormat:@"%@",isOn]};
            [weakSelf.datas replaceObjectAtIndex:0 withObject:section1];
            [weakSelf.tableView reloadData];
        }];
        return cell;
    }
    
    static NSString *IdentifierLocationRadiusCell = @"IdentifierLocationRadiusCell";
    CHUnitCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierLocationRadiusCell forIndexPath:indexPath];
    [cell setTitle:info[@"title"] detail:info[@"value"]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *info = [self.datas objectAtIndex:indexPath.section];
    NSString *title = info[@"title"];
    
    if ([title isEqualToString:@"时间间隔"]) {
        CHSetTimeIntervalController *controller = (CHSetTimeIntervalController *)[[UIStoryboard mainStoryboard] setTimeIntervalController];
        [controller setDidSelectedTimeBlock:^(NSString *timeStr) {
            NSDictionary *section2 = @{@"title":@"时间间隔",@"value":timeStr};
            [self.datas replaceObjectAtIndex:1 withObject:section2];
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}


@end
