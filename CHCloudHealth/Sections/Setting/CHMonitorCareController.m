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
    
    
}

#pragma mark -

- (void)getDatas{
    double delayInSeconds = 1;
    dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    // 得到全局队列
    dispatch_queue_t concurrentQueue = dispatch_get_main_queue();
    // 延期执行
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        [self.datas addObject:@""];
        [self.tableView reloadData];
    });
}
- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    
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
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 || indexPath.section == 0) {
        return 44;
    }
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        static NSString *IdentifierLocationHeaderCell = @"IdentifierLocationHeaderCell";
        CHSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierLocationHeaderCell forIndexPath:indexPath];
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
