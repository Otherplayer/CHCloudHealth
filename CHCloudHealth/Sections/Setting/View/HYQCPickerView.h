//
//   /\_/\
//   \_ _/
//    / \ not
//    \_/
//
//  Created by __无邪_ on 1/28/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYQCPickerView : UIView
@property (nonatomic, strong)void(^didClickedOkAction)(NSString *result);
- (void)showInView:(UIView *)superView items:(NSArray *)items;

@end
