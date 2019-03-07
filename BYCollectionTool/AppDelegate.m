//
//  AppDelegate.m
//  BYCollectionTool
//
//  Created by biyu6 on 2019/3/6.
//  Copyright © 2019 biyu6. All rights reserved.
//

#import "AppDelegate.h"
#import "BYHomeVC.h"

@interface AppDelegate ()

@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = BYWhiteColor1;
    BYHomeVC *homeVC = [[BYHomeVC alloc]init];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:homeVC];
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];//避免在同一个界面同时点击多个button，iOS8.0以上
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {//挂起、相当于进入了后台（上划进入网络控制台、来电话了）
}
- (void)applicationDidEnterBackground:(UIApplication *)application {//进入后台
}
- (void)applicationWillEnterForeground:(UIApplication *)application {//将要进入前台
}
- (void)applicationDidBecomeActive:(UIApplication *)application {//进入前台
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}
- (void)applicationWillTerminate:(UIApplication *)application {//程序即将退出
}

@end
