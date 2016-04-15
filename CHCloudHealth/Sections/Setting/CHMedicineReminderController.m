//
//  CHMedicineReminderController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHMedicineReminderController.h"
#import "CHSwitchCell.h"
#import "CHUnitCell.h"
#import "HYQCPickerView.h"

@interface CHMedicineReminderController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *pickerDatas;
@end

@implementation CHMedicineReminderController
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

- (void)getDatas{
    [[NetworkingManager sharedManager] getMedicineSetting:[CHUser sharedInstance].deviceId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                
                
                NSDictionary *info = responseData[@"data"];
                NSInteger value = [info[@"medicationSwitch"] isEmptyObject] ? 0 : 1;
                NSString *time1 = [NSString stringWithFormat:@"%@",info[@"medicationTime1"]];
                NSString *time2 = [NSString stringWithFormat:@"%@",info[@"medicationTime2"]];
                NSString *time3 = [NSString stringWithFormat:@"%@",info[@"medicationTime3"]];
                
                NSDictionary *section1 = @{@"type":@(1),@"title":@"服药提醒",@"value":[NSString stringWithFormat:@"%@",@(value)]};
                [self.datas addObject:section1];
                
                NSDictionary *section2 = @{@"type":@(2),@"title":@"1",@"value":time1};
                NSDictionary *section3 = @{@"type":@(2),@"title":@"2",@"value":time2};
                NSDictionary *section4 = @{@"type":@(2),@"title":@"3",@"value":time3};
                [self.datas addObject:section2];
                [self.datas addObject:section3];
                [self.datas addObject:section4];
                
                self.tableView.loading = NO;
                [self.tableView reloadData];
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
    
    NSString *time1 = self.datas[1][@"value"];
    NSString *time2 = self.datas[2][@"value"];
    NSString *time3 = self.datas[3][@"value"];
    
    [[NetworkingManager sharedManager] setMedicineSetting:[CHUser sharedInstance].deviceId medicationSwitch:state t1:time1 t2:time2 t3:time3 completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        if (success) {
            self.tableView.loading = NO;
            [HYQShowTip showTipTextOnly:@"设置成功" dealy:2];
        }else{
            self.tableView.loading = NO;
            [HYQShowTip showTipTextOnly:errDesc dealy:2];
        }
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
    NSInteger type = [info[@"type"] integerValue];
    if (type == 1) {
        static NSString *IdentifierReminderHeaderCell = @"IdentifierReminderHeaderCell";
        CHSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierReminderHeaderCell forIndexPath:indexPath];
        [cell configureTitle:info[@"title"] state:[info[@"value"] integerValue]];
        return cell;
    }else if (type == 2){
        static NSString *IdentifierReminderCell = @"IdentifierReminderCell";
        CHUnitCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierReminderCell forIndexPath:indexPath];
        [cell.textLabel setText:info[@"value"]];
        return cell;
    }
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *info = [[NSMutableDictionary alloc] initWithDictionary:[self.datas objectAtIndex:indexPath.section]];
    NSInteger type = [info[@"type"] integerValue];
    
    if (type == 2) {
        
        WS(weakSelf);
        
        HYQCPickerView *pickerView = [[HYQCPickerView alloc] init];
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [pickerView showInView:window items:@[self.pickerDatas]];
        [pickerView setDidClickedOkAction:^(NSString *result) {
            [info setObject:result forKey:@"value"];
            [weakSelf.datas replaceObjectAtIndex:indexPath.section withObject:info];
            [weakSelf.tableView reloadData];
        }];
        
    }
    
}



- (NSMutableArray *)pickerDatas{
    if (!_pickerDatas) {
        _pickerDatas = [[NSMutableArray alloc] init];
        for (int i = 0; i < 24; i++) {
            NSString *time = [NSString stringWithFormat:@"%02d:00",i];
            [_pickerDatas addObject:time];
        }
    }
    return _pickerDatas;
}














@end
