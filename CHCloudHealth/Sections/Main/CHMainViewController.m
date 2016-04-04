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

@end

@implementation CHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self installRevealGesture];
    [self setTitle:@"慈海云健康"];
    
    
    [self.tableView blankTableFooterView];
    
    self.tableView.descriptionText = @"连接设备后\n才会显示数据哦";
    self.tableView.loadedImageName = @"ios_icon_17";
    self.tableView.buttonText = @"绑定设备";
    [self.tableView clickLoading:^{
        
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldGotoSubMenuController:) name:kNotificationMenuController object:nil];
    
    [self getDatas];
    
    double delayInSeconds = 3;
    dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    // 得到全局队列
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 延期执行
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        self.tableView.loading = NO;
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -

- (void)getDatas{
    self.tableView.loading = YES;
    
}


#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 221;
    }
    return 142;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString *identifierMenuHeader = @"IdentifierMainHeader";
        CHMainHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierMenuHeader forIndexPath:indexPath];
        return cell;
    }
    
    static NSString *identifierMainState = @"IdentifierMainState";
    CHMainStateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierMainState forIndexPath:indexPath];
    return cell;
}








#pragma mark - Action

- (void)shouldGotoSubMenuController:(NSNotification *)notification{
    dispatch_async(dispatch_get_main_queue(), ^{
        ViewController *controller = [[ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:NO];
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
