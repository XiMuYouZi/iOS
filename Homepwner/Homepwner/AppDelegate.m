//
//  AppDelegate.m
//  Homepwner
//
//  Created by Mia on 15/10/15.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "AppDelegate.h"
#import "ItemsViewController.h"
#import "ItemStore.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //把itemsviewcontroller设置为navigationcontroller的根view，再把navigationcontroller设置为uiwindow的根view
    ItemsViewController *itemViewController= [[ItemsViewController alloc]init];
    UINavigationController *navController= [[UINavigationController alloc]initWithRootViewController:itemViewController];
    self.window.rootViewController=navController;
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


//当用户点击home键返回到主界面的时候，需要触发保存方法saveChange：
- (void)applicationDidEnterBackground:(UIApplication *)application {

    bool success=[[ItemStore shareStore]saveChanges];
    if (success) {
        NSLog(@"saved all of the BNRItems");
    }else{
        NSLog(@"Could not save any of BNRItems");
    }
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
