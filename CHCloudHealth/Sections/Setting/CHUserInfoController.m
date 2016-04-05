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

@interface CHUserInfoController ()
@property (nonatomic, strong) NSArray *datas;
@end

@implementation CHUserInfoController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton];
    
    self.datas = @[@[@{@"title":@"头像"}],@[@{@"title":@"昵称"},@{@"title":@"性别"},@{@"title":@"手机号"}]];
    
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
    if (indexPath.section == 0) {
        static NSString *identifierUserinfoHeader = @"IdentifierUserinfoHeader";
        CHUnitAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierUserinfoHeader forIndexPath:indexPath];
        return cell;
    }
    
    static NSString *identifierUserinfoBody = @"IdentifierUserinfoBody";
    CHUnitCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierUserinfoBody forIndexPath:indexPath];
    
    return cell;
}


@end
