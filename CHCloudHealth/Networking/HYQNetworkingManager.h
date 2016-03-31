//
//  HYQNetworkingManager.h
//  HotYQ
//
//  Created by __无邪_ on 15/10/10.
//  Copyright © 2015年 hotyq. All rights reserved.
//

#import "GGBaseNetwork.h"
#import <JSONModel.h>

@interface HYQNetworkingManager : GGBaseNetwork

+ (instancetype)sharedManager;




- (void)getLaunchAdvertisementCompletedHandler:(GGRequestCallbackBlock)completed;















@end
