//
//  AppDelegate.m
//  Nerdfeed
//
//  Created by Mia on 15/10/26.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "AppDelegate.h"
#import "CourseTableViewController.h"
#import "WebViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


//在appdelegate中把从视图控制器设置为UISplitViewController的委托，当设备处在竖屏模式的时候
//这个视图控制器就会收到委托消息，并创建一个指向特定UIBarButtonItem对象的指针，点击该bar
//就会使用UIPopoverController显示主视图控制器

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    CourseTableViewController *cvc=[[CourseTableViewController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *masterNav=[[UINavigationController alloc]initWithRootViewController:cvc];
    WebViewController *wvc=[[WebViewController alloc]init];
    cvc.webViewController=wvc;
//    self.window.rootViewController=masterNav;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        UINavigationController *detailNav=
        [[UINavigationController alloc]initWithRootViewController:wvc];
        UISplitViewController *svc=[[UISplitViewController alloc]init];
//        这里把从视图控制器设置为委托是为了后面在竖排可以显示主视图控制器来做准备的
        svc.delegate=wvc;
        
        svc.viewControllers=@[masterNav,detailNav ];
        self.window.rootViewController=svc;
    }else{
        self.window.rootViewController=masterNav;
    }
    
    self.window.backgroundColor=[UIColor whiteColor];
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
