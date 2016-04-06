//
//   /\_/\
//   \_ _/
//    / \ not
//    \_/
//
//  Created by __无邪_ on 4/1/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHRootViewController: UIViewController

@property (nonatomic, assign) BOOL fullScreenPopGestureDisabled; //To disable this pop gesture of a view controller:


- (void)installRevealGesture;

- (void)hidenKeyboard;



/// 网络是否连接
- (BOOL)isReachable;
/// 是否登录
- (BOOL)isLogin;
- (void)gotoLogin;
/// 判断网络是否连接，未连接时有提示
- (BOOL)canGo;



@end
