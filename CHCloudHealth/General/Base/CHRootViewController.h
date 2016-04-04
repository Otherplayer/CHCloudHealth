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

- (void)installRevealGesture;

- (void)hidenKeyboard;



/// 网络是否连接
- (BOOL)isReachable;
/// 是否登录
- (BOOL)isLogin;
/// 判断网络是否连接，未连接时有提示
- (BOOL)canGo;



@end
