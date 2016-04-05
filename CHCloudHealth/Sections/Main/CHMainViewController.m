//
//  CHMainViewController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 4/1/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "CHMainViewController.h"
#import "ViewController.h"
#import "CHMainHeaderCell.h"
#import "CHMainStateCell.h"

@interface CHMainViewController ()
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
    
    
    [self.tableView blankTableFooterView];
    self.tableView.descriptionText = @"连接设备后\n才会显示数据哦";
    self.tableView.loadedImageName = @"ios_icon_17";
    self.tableView.buttonText = @"绑定设备";
    [self.tableView clickLoading:^{
        [self getDatas];
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldGotoSubMenuController:) name:kNotificationMenuController object:nil];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![self isLogin]) {
        [self gotoLogin];
    }else{
        [self getDatas];
    }
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
                [self.datas addObject:responseData[@"data"]];
                self.tableView.loading = NO;
                [self.tableView reloadData];
                
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
                [self.datas addObjectsFromArray:responseData[@"data"]];
                [self.tableView reloadData];
            });
        }else{
            [HYQShowTip showTipTextOnly:errDesc dealy:2];
        }
    }];
}


#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 221;
    }
    return 154;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *info = [self.datas objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        static NSString *identifierMenuHeader = @"IdentifierMainHeader";
        CHMainHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierMenuHeader forIndexPath:indexPath];
        [cell configure:info];
        return cell;
    }
    
    static NSString *identifierMainState = @"IdentifierMainState";
    CHMainStateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierMainState forIndexPath:indexPath];
    [cell configure:info];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
