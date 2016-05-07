//
//  CHUserInfoController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHUserInfoController.h"
#import "CHUnitCell.h"
#import "CHUnitAvatarCell.h"
#import "HYQHelperCamera.h"
#import "CHChangeNameController.h"

@interface CHUserInfoController ()
@property (nonatomic, strong) NSArray *datas;
//@property (nonatomic, strong) NSString *name;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation CHUserInfoController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton];
    
//    self.datas = @[
//  @[
////  @{@"title":@"头像",@"detail":[CHUser sharedInstance].avatarurl ? [CHUser sharedInstance].avatarurl : @""}
//  ],
//                   
//  @[@{@"title":@"昵称",@"detail":[CHUser sharedInstance].name ? [CHUser sharedInstance].name : @""},
////                     @{@"title":@"性别",@"detail":@""},
////                     @{@"title":@"手机号",@"detail":[CHUser sharedInstance].phoneNumber ? [CHUser sharedInstance].phoneNumber : @""}
//    ]
//  ];
    
//    [self addRightButton2NavWithTitle:@"确定"];
    [self.tableView blankTableFooterView];
    [self getDatas];
    
}
#pragma mark - Action
- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
//    if (self.name && self.name.length > 0) {
//        [[NetworkingManager sharedManager] updateUserInfo:[CHUser sharedInstance].uid name:self.name completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
//            if (success) {
//                [HYQShowTip showTipTextOnly:@"修改成功" dealy:2];
//            }else{
//                [HYQShowTip showTipTextOnly:errDesc dealy:2];
//            }
//        }];
//        
//    }
}

- (void)getDatas{
    [HYQShowTip showProgressWithText:@"" dealy:60];
    [[NetworkingManager sharedManager] getBindUserInfo:[CHUser sharedInstance].deviceUserId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                NSDictionary *info = responseData[@"data"];
                
                NSString *detail = [NSString stringWithFormat:@"\n姓名：%@\n设备电话：%@\n出生日期：%@\n地址：%@\n身高：%@\n体重：%@\n步长：%@\n慢性病史：%@\n",info[@"name"],info[@"simNum"],info[@"birthday"],info[@"address"],info[@"height"],info[@"weight"],info[@"medicalRecord"],info[@"stepLength"]];
                
                self.datas = @[@{@"title":detail}];
                [self.tableView reloadData];
                
                [HYQShowTip hideImmediately];
//                [HYQShowTip showTipTextOnly:@"修改成功" dealy:2];
            }else{
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
        });
    }];
}


#pragma mark - Delegate

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return [self.datas count];
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    NSDictionary *info = self.datas[indexPath.row];
    //    NSString *title = info[@"title"];
    NSString *detail = info[@"title"];
    
    CGFloat height = [detail heightWithFont:[UIFont systemFontOfSize:17] size:CGSizeMake(kMainWidth - 20, 10000)] + 1;
    
    
    return height;
//    if (indexPath.section == 0) {
//    }
//    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *info = self.datas[indexPath.row];
//    NSString *title = info[@"title"];
    NSString *detail = info[@"title"];
//    if (indexPath.section == 0) {
//        static NSString *identifierUserinfoHeader = @"IdentifierUserinfoHeader";
//        CHUnitAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierUserinfoHeader forIndexPath:indexPath];
//        [cell setTitle:title avatar:detail];
//        return cell;
//    }
    
    static NSString *identifierUserinfoBody = @"IdentifierUserinfoBody";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierUserinfoBody forIndexPath:indexPath];
//    [cell setTitle:title detail:[CHUser sharedInstance].name];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell.textLabel setText:detail];
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        [[HYQHelperCamera sharedInstance] showCustomCameraPickerWithResultBlock:^(UIImage *image) {
//            
//        }];
//    }else{
//        if (indexPath.row == 0) {
//            WS(weakSelf);
//            CHChangeNameController *controller = (CHChangeNameController *)[[UIStoryboard mainStoryboard] changeNameController];
//            controller.type = 0;
//            [controller setDidEditSuccessBlock:^(NSString *result) {
//                weakSelf.name = result;
//                [CHUser sharedInstance].name = result;
//                [weakSelf.tableView reloadData];
//            }];
//            [self.navigationController pushViewController:controller animated:YES];
//        }else if (indexPath.row == 1){
//            HYQActionSheet *actionSheet = [[HYQActionSheet alloc] initWithTitle:@"请选择性别" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
//            [actionSheet handlerClickedButton:^(NSInteger btnIndex) {
//            }];
//            [actionSheet showInView:self.view];
//        }else if (indexPath.row == 2){
//            CHChangeNameController *controller = (CHChangeNameController *)[[UIStoryboard mainStoryboard] changeNameController];
//            controller.type = 1;
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//    }
}


@end
