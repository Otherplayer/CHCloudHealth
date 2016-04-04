//
//  CHUserInfoController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHUserInfoController.h"

@implementation CHUserInfoController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton];
    
}


#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100;
    }
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString *identifierUserinfoHeader = @"IdentifierUserinfoHeader";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierUserinfoHeader forIndexPath:indexPath];
        return cell;
    }
    
    static NSString *identifierUserinfoBody = @"IdentifierUserinfoBody";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierUserinfoBody forIndexPath:indexPath];
    return cell;
}


@end
