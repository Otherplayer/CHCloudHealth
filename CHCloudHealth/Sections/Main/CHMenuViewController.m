//
//  CHMenuViewController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 4/1/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "CHMenuViewController.h"

@interface CHMenuViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIView *tableHeaderView;
@property (strong, nonatomic) NSMutableArray *datas;
@end

@implementation CHMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datas = [[NSMutableArray alloc] init];
    //self.tableView.tableHeaderView = self.tableHeaderView;
    [self.tableView blankTableFooterView];
    
    // section first
    [self.datas addObject:@[@{@"title":@"基础信息",@"image":@""}]];
    // section second
    [self.datas addObject:@[@{@"title":@"基础信息"},
                            @{@"title":@"基础信息"},
                            @{@"title":@"基础信息"},
                            @{@"title":@"基础信息"},
                            @{@"title":@"基础信息"},
                            @{@"title":@"基础信息"},
                            @{@"title":@"基础信息"},
                            @{@"title":@"基础信息"},]];
    // section third
    [self.datas addObject:@[@{@"title":@"App管理"}]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Delegate


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    
    SWRevealViewController *revealController = self.revealViewController;
    [revealController revealToggleAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationMenuController object:nil];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 64;
    }
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainWidth, 64)];
        titleView.backgroundColor = [UIColor greenColor];
        return titleView;
    }
    return nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.datas objectAtIndex:section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifierMenuHeader = @"IdentifierMenuHeader";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierMenuHeader forIndexPath:indexPath];
        return cell;
    }
    static NSString *identifierCell = @"IdentifierMenu";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - configure

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}


//- (UIView *)tableHeaderView{
//    if (!_tableHeaderView) {
//        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainWidth - 120, 200)];
//        _tableHeaderView.backgroundColor = [UIColor cyanColor];
//    }
//    return _tableHeaderView;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
