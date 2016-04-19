//
//  CHRelationShipController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "CHRelationShipController.h"
#import "CHAddRelationNumController.h"
#import "CHUnitCell.h"

@interface CHRelationShipController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation CHRelationShipController
#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton];
    
    [self addRightButton2NavWithTitle:@"添加"];
    
    self.datas = [[NSMutableArray alloc] init];
    
    [self.tableView blankTableFooterView];
    self.tableView.descriptionText = @"还没有添加过亲情号码哦";
    self.tableView.loadedImageName = @"ios_icon_17";
    
    self.tableView.loading = YES;
    [self getDatas];
    
    
    
    
}



#pragma mark - 

- (void)rightBarButtonPressed:(id)rightBarButtonPressed{
    CHAddRelationNumController *controller = (CHAddRelationNumController *)[[UIStoryboard mainStoryboard] addRelationNumController];
    WS(weakSelf);
    [controller setDidAddReleationNumBlock:^{
        [weakSelf getDatas];
    }];
    CHBaseNavigationController *nav = [[CHBaseNavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)getDatas{
    
    [[NetworkingManager sharedManager] getListFamliyNumber:[CHUser sharedInstance].deviceUserId completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                [self.datas removeAllObjects];
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
    NSDictionary *info = self.datas[indexPath.row];
    static NSString *identifierMessageCell = @"IdentifierRelationShipCell";
    CHUnitCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierMessageCell forIndexPath:indexPath];
    //mobile  name relation
    [cell setTitle:info[@"name"] detail:info[@"relation"] mobile:info[@"mobile"]];
    return cell;
}



@end
