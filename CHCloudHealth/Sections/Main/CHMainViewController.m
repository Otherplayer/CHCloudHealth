//
//  CHMainViewController.m
//  CHCloudHealth
//
//  Created by __无邪_ on 4/1/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "CHMainViewController.h"
#import "ViewController.h"

@interface CHMainViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@end

@implementation CHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self installRevealGesture];
    [self setTitle:@"慈海云健康"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldGotoSubMenuController:) name:kNotificationMenuController object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shouldGotoSubMenuController:(NSNotification *)notification{
    dispatch_async(dispatch_get_main_queue(), ^{
        ViewController *controller = [[ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:NO];
    });
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
