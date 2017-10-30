//
//  AppDelegate.m
//  YTWeather
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 Jaten. All rights reserved.
//

#import "AppDelegate.h"

#import "YTMainViewController.h"
#import "YTLaunchADViewController.h"
#import "YTNewFeatureViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    //当前版本号
    NSString * curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    //保存的版本号
    NSString * lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:ShortVersionKey];
    
    UIViewController * rootVC;
    //判断版本
    if([lastVersion isEqualToString:curVersion]) {
        //进入广告页
        rootVC = [[YTLaunchADViewController alloc]init];
    }else {
        //进入新特性
        rootVC = [[YTNewFeatureViewController alloc]init];
        //更新版本
        [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:ShortVersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
