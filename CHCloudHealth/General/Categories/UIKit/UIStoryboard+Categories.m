//
//  UIStoryboard+Categories.m
//  CHCloudHealth
//
//  Created by __无邪_ on 16/4/4.
//  Copyright © 2016年 fqah. All rights reserved.
//

#import "UIStoryboard+Categories.h"

@implementation UIStoryboard (Categories)
+ (instancetype)mainStoryboard{
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}
+ (instancetype)loginStoryboard{
    return [UIStoryboard storyboardWithName:@"Login" bundle:nil];
}

#pragma mark - Entry

- (UIViewController *)statisticsController{
    return [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"CHStatisticsController"];
}

- (UIViewController *)messageController{
    return [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"CHMessageController"];
}

- (UIViewController *)changeNameController{
    return [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"CHChangeNameController"];
}


- (CHBaseNavigationController *)bindController{
    return [[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:@"CHNavBindController"];
}

- (CHBaseNavigationController *)loginController{
    return [[UIStoryboard loginStoryboard] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
}

@end
