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
@property (nonatomic, strong) NSString *name;
@end

@implementation CHUserInfoController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton];
    
    self.datas = @[
  @[
//  @{@"title":@"头像",@"detail":[CHUser sharedInstance].avatarurl ? [CHUser sharedInstance].avatarurl : @""}
  ],
                   
  @[@{@"title":@"昵称",@"detail":[CHUser sharedInstance].name ? [CHUser sharedInstance].name : @""},
//                     @{@"title":@"性别",@"detail":@""},
//                     @{@"title":@"手机号",@"detail":[CHUser sharedInstance].phoneNumber ? [CHUser sharedInstance].phoneNumber : @""}
    ]];
    
    [self addRightButton2NavWithTitle:@"确定"];
    
}
#pragma mark - Action
- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    if (self.name && self.name.length > 0) {
        [[NetworkingManager sharedManager] updateUserInfo:[CHUser sharedInstance].uid name:self.name completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
            if (success) {
                [HYQShowTip showTipTextOnly:@"修改成功" dealy:2];
            }else{
                [HYQShowTip showTipTextOnly:errDesc dealy:2];
            }
        }];
        
    }
}


#pragma mark - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.datas count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *info = self.datas[indexPath.section][indexPath.row];
    NSString *title = info[@"title"];
    NSString *detail = info[@"detail"];
    if (indexPath.section == 0) {
        static NSString *identifierUserinfoHeader = @"IdentifierUserinfoHeader";
        CHUnitAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierUserinfoHeader forIndexPath:indexPath];
        [cell setTitle:title avatar:self.name];
        return cell;
    }
    
    static NSString *identifierUserinfoBody = @"IdentifierUserinfoBody";
    CHUnitCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierUserinfoBody forIndexPath:indexPath];
    [cell setTitle:title detail:detail];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [[HYQHelperCamera sharedInstance] showCustomCameraPickerWithResultBlock:^(UIImage *image) {
            
        }];
    }else{
        if (indexPath.row == 0) {
            WS(weakSelf);
            CHChangeNameController *controller = (CHChangeNameController *)[[UIStoryboard mainStoryboard] changeNameController];
            controller.type = 0;
            [controller setDidEditSuccessBlock:^(NSString *result) {
                weakSelf.name = result;
                [tableView reloadData];
            }];
            [self.navigationController pushViewController:controller animated:YES];
        }else if (indexPath.row == 1){
            HYQActionSheet *actionSheet = [[HYQActionSheet alloc] initWithTitle:@"请选择性别" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
            [actionSheet handlerClickedButton:^(NSInteger btnIndex) {
            }];
            [actionSheet showInView:self.view];
        }else if (indexPath.row == 2){
            CHChangeNameController *controller = (CHChangeNameController *)[[UIStoryboard mainStoryboard] changeNameController];
            controller.type = 1;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}


@end
