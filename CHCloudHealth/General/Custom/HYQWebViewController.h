//
//  HYQWebViewController.h
//  HYQuan
//
//  Created by fqah on 12/11/15.
//  Copyright © 2015 fqah. All rights reserved.
//

#import "CHRootViewController.h"

@interface HYQWebViewController : CHRootViewController
@property (nonatomic, strong)NSString *urlStr;
@property (nonatomic, strong)NSDictionary *params;
@property (nonatomic, assign)NSInteger isNewNavigation;//1.是根视图，其它不设置

@end
