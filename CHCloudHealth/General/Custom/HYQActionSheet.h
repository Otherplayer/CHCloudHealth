//
//   /\_/\
//   \_ _/
//    / \ not
//    \_/
//
//  Created by fqah on 1/5/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYQActionSheet : UIActionSheet

- (void)handlerClickedButton:(void (^)(NSInteger btnIndex))aBlock;


@end
