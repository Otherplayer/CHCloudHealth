//
//  HYQHealthReportController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/6.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHHealthReportController.h"

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
    
}

#pragma mark -

- (void)getDatas{
    double delayInSeconds = 1;
    dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    // 得到全局队列
    dispatch_queue_t concurrentQueue = dispatch_get_main_queue();
    // 延期执行
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        self.tableView.loading = NO;
        [self.tableView reloadData];
    });
}


#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierHealthReportCell = @"IdentifierHealthReportCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierHealthReportCell forIndexPath:indexPath];
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
