//
//  AppDelegate.m
//  CHCloudHealth
//
//  Created by __无邪_ on 3/29/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "AppDelegate.h"
#import <JPUSHService.h>



#define kAPPKEY_JPUSH @"3dff2d45c49d8708ec01be57"
#define kAPPKEY_BAIDU_MAP @"rYSPcaBk64BaO4lWZnhVfS7za1UKssE0"//rYSPcaBk64BaO4lWZnhVfS7za1UKssE0


@interface AppDelegate (){
    BMKMapManager* _mapManager;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Register Splite
    [[FQAHReachibility sharedInstance] startMonitoringInternetStates];
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"FQAHNetworking.sqlite"];
    [self installJPUSH:launchOptions];
    [self installBaiduMap];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [MagicalRecord cleanUp];
    
    
}



#pragma mark - 推送

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    
    
    [JPUSHService registerDeviceToken:deviceToken];
    
    //04baaca75ec37a3899f8e0a0a21939f4727d96f4b02a372b2da6ca53cf77183c
    NSString *token = [[deviceToken description] trimCharacterToToken];
    NSUserDefaults *standUserDefaults = [NSUserDefaults standardUserDefaults];
    [standUserDefaults setObject:token forKey:kAppToken];
    [standUserDefaults synchronize];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (application.applicationState == UIApplicationStateInactive) {
        
        // Required,For systems with less than or equal to iOS6
        [JPUSHService handleRemoteNotification:userInfo];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if (application.applicationState == UIApplicationStateInactive) {
        // IOS 7 Support Required
        [JPUSHService handleRemoteNotification:userInfo];
        completionHandler(UIBackgroundFetchResultNewData);
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}








- (void)installJPUSH:(NSDictionary *)launchOptions{
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    // Required
    //如需兼容旧版本的方式，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化和同时使用pushConfig.plist文件声明appKey等配置内容。
    //isProduction 是否生产环境. 如果为开发状态,设置为 NO; 如果为生产状态,应改为 YES.
    BOOL isProduction = YES;
//    if (DEBUG) {
//        isProduction = NO;
//    }

    [JPUSHService setupWithOption:launchOptions appKey:kAPPKEY_JPUSH channel:nil apsForProduction:isProduction];
}
- (void)installBaiduMap{
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:kAPPKEY_BAIDU_MAP generalDelegate:nil];
    if (!ret) {
        NSLog(@"Baidu map manager start failed!");
    }
}













@end
