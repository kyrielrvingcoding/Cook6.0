//
//  AppDelegate.m
//  Cook
//
//  Created by 诸超杰 on 16/4/23.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (_is_flip) {
        return UIInterfaceOrientationMaskLandscape;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:SCREENBOUNDS];
    
    //    NSString *key = @"CFBundleVersion";
    //    //获取上次打开时的版本号(从沙盒中获取)
    //    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //    //获取当前的版本号(从Info.plist文件中获取)
    //    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    self.window.rootViewController = [[BaseTabBarController alloc] init];
    
    //    if ([lastVersion isEqualToString:currentVersion]) {
    //        self.window.rootViewController = [[BaseTabBarController alloc] init];
    //    } else {//版本号不一样，显示新特性
    //        self.window.rootViewController = [[NewfeatureViewController alloc] init];
    //        //将当前版本号存进沙盒
    //        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
    //        [[NSUserDefaults standardUserDefaults] synchronize];
    //    }
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
