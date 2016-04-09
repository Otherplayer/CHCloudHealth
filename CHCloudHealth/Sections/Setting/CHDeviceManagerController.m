//
//  CHDeviceManagerController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/9.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHDeviceManagerController.h"
#import "CMMessageCell.h"

@interface CHDeviceManagerController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation CHDeviceManagerController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    
    self.datas = [[NSMutableArray alloc] init];
    
    [self.tableView blankTableFooterView];
    self.tableView.descriptionText = @"还没有绑定设备哦哦";
    self.tableView.loadedImageName = @"ios_icon_17";
    
    self.tableView.loading = YES;
    [self getDatas];
    
}

#pragma mark -

- (void)getDatas{
    
    [[NetworkingManager sharedManager] getBindDeviceListInfo:[CHUser sharedInstance].uid completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                [self.datas addObjectsFromArray:responseData[@"data"]];
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
    static NSString *identifierMessageCell = @"IdentifierMessageCell";
    CMMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierMessageCell forIndexPath:indexPath];
    NSDictionary *info = self.datas[indexPath.row];
//    bindDate = 1460131200000;
//    deviceId = "55dd6896-494a-47a0-b67a-45eb00552b75";
//    deviceName = "\U624b\U8868\U4e00\U53f7";
//    imei = 12345678;
//    status = 0;
    [cell configureTitle:info[@"deviceName"] detail:info[@"imei"] time:[NSString stringWithFormat:@"%@",info[@"bindDate"]] state:[info[@"status"] integerValue]];
    
    
    return cell;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
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
