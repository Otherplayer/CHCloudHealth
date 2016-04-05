//
//   /\_/\
//   \_ _/
//    / \ not
//    \_/
//
//  Created by fqah on 1/5/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "HYQActionSheet.h"
#import <objc/runtime.h>

static const char HYQUIActionSheet_key_clicked;

@interface HYQActionSheet ()<UIActionSheetDelegate>

@end

@implementation HYQActionSheet

-(void)handlerClickedButton:(void (^)(NSInteger btnIndex))aBlock{
    self.delegate = self;
    objc_setAssociatedObject(self, &HYQUIActionSheet_key_clicked, aBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark -AlertViewDelegate

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    void (^block)(NSInteger btnIndex) = objc_getAssociatedObject(self, &HYQUIActionSheet_key_clicked);
    if (block) block(buttonIndex);
}

@end
