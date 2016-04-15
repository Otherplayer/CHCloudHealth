//
//  HYQHealthReportController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/6.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHHealthReportController.h"
#import "CMMessageCell.h"

@interface CHHealthReportController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation CHHealthReportController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    
    self.datas = [[NSMutableArray alloc] init];
    
    [self.tableView blankTableFooterView];
    self.tableView.descriptionText = @"还没有健康报告哦";
    self.tableView.loadedImageName = @"ios_icon_17";
    
    self.tableView.loading = YES;
    [self getDatas];
    
    
    [self addRightButton2NavWithTitle:@"hhh"];
    
}

- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    [[NetworkingManager sharedManager] getHealthRecordDetailInfo:@"5b12780b-21dd-4e42-8ce7-dddbd92699a0" completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        
    }];
}


#pragma mark -

- (void)getDatas{
    
    if ([self canGo]) {
        
        [HYQShowTip showProgressWithText:@"" dealy:30];
        [[NetworkingManager sharedManager] getHealthRecordInfo:[CHUser sharedInstance].deviceUserId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    self.tableView.loading = NO;
                    [self.datas removeAllObjects];
                    NSArray *results = responseData[@"data"];
                    [self.datas addObjectsFromArray:results];
                    [self.tableView reloadData];
                    [HYQShowTip hideImmediately];
                }else{
                    self.tableView.loading = NO;
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
                
            });
        }];
        
    }
    
}


#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *info = self.datas[indexPath.row];
    static NSString *identifierHealthReportCell = @"IdentifierHealthReportCell";
    CMMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierHealthReportCell forIndexPath:indexPath];
    [cell configureTitle:info[@"title"] detail:info[@"content"] name:info[@"name"]];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
