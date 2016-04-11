//
//  CHSetTimeIntervalController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/9.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHSetTimeIntervalController.h"


@interface CHSetTimeIntervalController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation CHSetTimeIntervalController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton];
//    [self addRightButton2NavWithTitle:@"确认"];
    
    self.datas = [[NSMutableArray alloc] init];
    
    [self.tableView setBackgroundColor:[UIColor color_f2f2f2]];
    [self.tableView blankTableFooterView];
    
    
    [self.datas addObjectsFromArray:@[@"5分钟",@"10分钟",@"15分钟",@"20分钟",@"25分钟",@"30分钟",@"1小时",@"2小时",@"永不"]];
    
}


- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    
}


#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *title = [self.datas objectAtIndex:indexPath.row];
    static NSString *IdentifierLocationHeaderCell = @"IdentifierLocationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierLocationHeaderCell forIndexPath:indexPath];
    [cell.textLabel setText:title];
    return cell;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = [self.datas objectAtIndex:indexPath.row];    
    if (self.didSelectedTimeBlock) {
        self.didSelectedTimeBlock(title);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
