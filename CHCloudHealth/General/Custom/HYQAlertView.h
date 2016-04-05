//
//  HYQAlertView.h
//  HotYQ
//
//  Created by __无邪_ on 15/7/22.
//  Copyright © 2015年 hotyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYQAlertView : UIAlertView

-(void)handlerClickedButton:(void (^)(NSInteger btnIndex))aBlock;


@end
