//
//  UIDevice+GGNetworkingMethods.m
//  GGNetwoking
//
//  Created by __无邪_ on 15/10/5.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "UIDevice+GGNetworkingMethods.h"
#include <sys/param.h>
#include <sys/mount.h>

@implementation UIDevice (GGNetworkingMethods)
+ (long long) freeDiskSpaceInBytes{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return freespace/1024;
}

@end
