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
    [self setupUMShare];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    //当前版本号
    NSString *curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    //保存的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:ShortVersionKey];
    
    UIViewController *rootVC;
    //判断版本
    if ([lastVersion isEqualToString:curVersion]) {
        //进入广告页
        rootVC = [[YTLaunchADViewController alloc] init];
    } else {
        //进入新特性
        rootVC = [[YTNewFeatureViewController alloc] init];
        //更新版本
        [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:ShortVersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)setupUMShare
{
    // 友盟初始化
    [[UMSocialManager defaultManager] openLog:YES];
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_APPKEY];
    
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"" appSecret:@"" redirectURL:nil];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APP_KEY appSecret:QQ_APP_SECRET redirectURL:@""];
    
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"" appSecret:@"" redirectURL:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
