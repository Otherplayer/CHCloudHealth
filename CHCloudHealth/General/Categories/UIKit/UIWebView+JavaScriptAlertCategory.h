//
//  UIWebView+JavaScriptAlertCategory.h
//  HYQuan
//
//  Created by __无邪_ on 3/22/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIWebView (JavaScriptAlertCategory)
- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;
@end
