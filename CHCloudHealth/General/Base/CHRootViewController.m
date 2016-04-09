//
//   /\_/\
//   \_ _/
//    / \ not
//    \_/
//
//  Created by __无邪_ on 4/1/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "CHRootViewController.h"
#import "UIApplication+Categories.h"
#import "UINavigationBar+Awesome.h"

@interface CHRootViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@end

@implementation CHRootViewController

#pragma mark - LifeCircle

//- (void)loadView{
//    [super loadView];
//    self.view.backgroundColor = [UIColor color_f2f2f2];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network Methods

#pragma mark - Action



#pragma mark - Delegate

#pragma mark - Private
- (void)setFullScreenPopGestureDisabled:(BOOL)fullScreenPopGestureDisabled{
    //To disable this pop gesture of a view controller:
    self.fd_interactivePopDisabled = fullScreenPopGestureDisabled;
}

- (void)setNavBarClear:(BOOL)flag{
    if (flag) {
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }else{
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor defaultColor]];
    }
}

- (void)hidenKeyboard{
    [UIApplication hideKeyboard];
}
- (BOOL)isReachable{
    return [FQAHReachibility sharedInstance].isReachable;
}
- (BOOL)isLogin{
    return [CHUser sharedInstance].islogin;
}
- (void)gotoLogin{
    CHBaseNavigationController *nav = [[UIStoryboard loginStoryboard] loginController];
    [self presentViewController:nav animated:YES completion:nil];
}
- (BOOL)canGo{
    BOOL isReachable = [self isReachable];
    if (isReachable) {
        return YES;
    }
    [HYQShowTip showTipInView:self.view tip:@"网络连接错误" dealy:2];
    return NO;
    
}

#pragma mark - Configure

- (void)installRevealGesture{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ){
        [self.revealButtonItem setTarget: revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer:revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer:revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer:revealViewController.tapGestureRecognizer];
    }
}


@end
