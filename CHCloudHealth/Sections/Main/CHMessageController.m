//
//  CHMessageController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 4/6/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "CHMessageController.h"
#import "CMMessageCell.h"
#import "HYQWebViewController.h"

@interface CHMessageController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation CHMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    
    self.datas = [[NSMutableArray alloc] init];
    
    [self.tableView blankTableFooterView];
    self.tableView.descriptionText = @"还没有消息哦";
    self.tableView.loadedImageName = @"ios_icon_17";
    
    self.tableView.loading = YES;
    [self getDatas];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}


#pragma mark -

- (void)getDatas{
    
    [[NetworkingManager sharedManager] getNoticeListInfo:[CHUser sharedInstance].uid page:1 size:12 completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                [self.datas addObjectsFromArray:responseData[@"data"][@"data"]];
                
                self.tableView.loading = NO;
                [self.tableView reloadData];
                
            }else{
                self.tableView.loading = NO;
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
        });

    }];
    
}

#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *info = self.datas[indexPath.row];
    NSString *title = [NSString stringWithFormat:@"%@",info[@"title"]];
    NSString *detail = [NSString stringWithFormat:@"%@",info[@"content"]];
    NSString *time = [NSString stringWithFormat:@"%@",info[@"createDate"]];
    NSInteger type = [info[@"msgType"] integerValue];
    //readStatus
    static NSString *identifierMessageCell = @"IdentifierMessageCell";
    CMMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierMessageCell forIndexPath:indexPath];
    [cell configureTitle:title detail:detail time:time type:type];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *info = self.datas[indexPath.row];
    NSString *noticeId = info[@"id"];
    
    HYQWebViewController *controller = [[HYQWebViewController alloc] init];
    controller.urlStr = HOTYQ_JAVA_API @"notice/getDetail";
    controller.params = @{@"noticeId":noticeId,@"userId":[CHUser sharedInstance].uid};
    [self.navigationController pushViewController:controller animated:YES];
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
