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
    
    [cell configureTitle:info[@"deviceName"] detail:info[@"imei"] time:[NSString stringWithFormat:@"%@",info[@"bindDate"]] state:[info[@"status"] integerValue]];
    
    
    return cell;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSDictionary *info = self.datas[indexPath.row];
        NSString *deviceId = [NSString stringWithFormat:@"%@",info[@"id"]];
        
        [[NetworkingManager sharedManager] unbindDevice:[CHUser sharedInstance].uid number:deviceId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    //解绑
                    [CHUser sharedInstance].deviceId = @"-1";
                    [CHUser sharedInstance].deviceUserId = @"-1";
                    [self.datas removeObjectAtIndex:indexPath.row];
                    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
                }else{
                    [HYQShowTip showTipTextOnly:errDesc dealy:2];
                }
            });
        }];
        
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
