//
//  UIWebView+JavaScriptAlertCategory.m
//  HYQuan
//
//  Created by __无邪_ on 3/22/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "UIWebView+JavaScriptAlertCategory.h"

@implementation UIWebView (JavaScriptAlertCategory)
- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame {
    UIAlertView* dialogue = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [dialogue show];
}
@end
