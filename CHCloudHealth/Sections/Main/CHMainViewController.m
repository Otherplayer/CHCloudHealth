//
//  CHMainViewController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 4/1/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "CHMainViewController.h"
#import "CHStatisticsController.h"
#import "CHBindController.h"
#import "ViewController.h"
#import "CHMainHeaderCell.h"
#import "CHMainStateCell.h"
#import "UIColor+Gradient.h"


@interface CHMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mailButtonItem;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation CHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self installRevealGesture];
    [self setTitle:@"慈海云健康"];
    self.datas = [[NSMutableArray alloc] init];
    
    [self.view setBackgroundColor:[UIColor gradientFromColor:[UIColor defaultColor] toColor:[UIColor whiteColor] height:kMainHeight]];
    
    [self.tableView blankTableFooterView];
    self.tableView.descriptionText = @"连接设备后\n才会显示数据哦";
    self.tableView.loadedImageName = @"ios_icon_17";
    self.tableView.buttonText = @"绑定设备";
    [self.tableView clickLoading:^{
        CHBaseNavigationController *nav = [[UIStoryboard mainStoryboard] bindController];
        [self presentViewController:nav animated:YES completion:nil];
//        if ([self isReachable]) {
//        }else{
//            [self getDatas];
//        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldGotoSubMenuController:) name:kNotificationMenuController object:nil];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavBarClear:YES];
    if (![self isLogin]) {
        [self gotoLogin];
    }else{
        [self getDatas];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setNavBarClear:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -

- (void)getDatas{
    
    self.tableView.loading = YES;
    [[NetworkingManager sharedManager] getDeviceInfo:[CHUser sharedInstance].uid completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.datas removeAllObjects];
                [self.datas addObject:@[responseData[@"data"]]];
                [self getHealthTypeInfo];
            });
        }else{
            self.tableView.loading = NO;
            [HYQShowTip showTipTextOnly:errDesc dealy:2];
        }
    }];
    
}

- (void)getHealthTypeInfo{
    [[NetworkingManager sharedManager] getHealthTypeInfo:[CHUser sharedInstance].uid completedHandler:^(BOOL success, NSString *errDesc, id responseData) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tableView.loading = NO;
                for (NSDictionary *info in responseData[@"data"]) {
                    [self.datas addObject:@[info]];
                }
                [self.tableView reloadData];
            });
        }else{
            self.tableView.loading = NO;
            [HYQShowTip showTipTextOnly:errDesc dealy:2];
        }
    }];
}


#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 221;
    }
    return 144;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *info = self.datas[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        static NSString *identifierMainHeader = @"IdentifierMainHeaderCell";
        CHMainHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierMainHeader forIndexPath:indexPath];
        [cell configure:info];
        return cell;
    }
    static NSString *identifierMainState = @"IdentifierMainStateCell";
    CHMainStateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierMainState forIndexPath:indexPath];
    [cell configure:info];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    if (indexPath.section > 0) {
        UIViewController *controller = [[UIStoryboard mainStoryboard] statisticsController];
        [self.navigationController pushViewController:controller animated:YES];
    }
}




#pragma mark - Action

- (void)shouldGotoSubMenuController:(NSNotification *)notification{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"%@",notification);
        
        NSString *identifier = notification.object;
        if (identifier) {
            UIViewController *controller = [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:identifier];
            [self.navigationController pushViewController:controller animated:NO];
        }
        
    });
}

- (IBAction)mailAction:(id)sender {
    CHBaseNavigationController *nav = [[UIStoryboard loginStoryboard] loginController];
    [self presentViewController:nav animated:YES completion:nil];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
////    Get the new view controller using [segue destinationViewController].
////    Pass the selected object to the new view controller.
//    
//    
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
*/

@end
