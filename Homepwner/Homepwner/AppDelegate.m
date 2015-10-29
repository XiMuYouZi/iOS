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


NSString * const NextItemValuePrefsKey=@"NextItemValue";
NSString *const NextItemNamePrefsKey=@"NextItemName";
@implementation AppDelegate


// 注册出厂设置，也就是设定默认设置
+(void)initialize
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary *factorySettings=@{NextItemNamePrefsKey:@"Coffee Cup",
                                    NextItemValuePrefsKey:@75};
    [defaults registerDefaults:factorySettings];
}


//设置状态恢复
-(BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder{
    return YES;
}

-(BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
   return YES;
}

//P463
-(UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    UIViewController *vc=[[UINavigationController alloc]init];
    vc.restorationIdentifier=[identifierComponents lastObject];
    if ([identifierComponents count]==1) {
        self.window.rootViewController=vc;
    }
    return vc;
}
//- (UIViewController *)application:(UIApplication *)application
//viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents
//                            coder:(NSCoder *)coder
//{
//    // Create a new navigation controller
//    UIViewController *vc = [[UINavigationController alloc] init];
//    
//    // The last object in the path array is the restoration
//    // identifier for this view controller
//    vc.restorationIdentifier = [identifierComponents lastObject];
//    
//    // If there is only 1 identifier component, then
//    // this is the root view controller
//    if ([identifierComponents count] == 1) {
//        self.window.rootViewController = vc;
//    }
//    
//    return vc;
//}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    如果是应用第一次启动，就不会触发状态恢复，此时需要创建各个视图
    if (!self.window.rootViewController) {
    //把itemsviewcontroller设置为navigationcontroller的根view，再把navigationcontroller设置为uiwindow的根view
    ItemsViewController *itemViewController= [[ItemsViewController alloc]init];
    UINavigationController *navController= [[UINavigationController alloc]initWithRootViewController:itemViewController];
    
//    把UINavigationController对象的类名设置为恢复表示
    navController.restorationIdentifier=NSStringFromClass([navController class]);
    
    self.window.rootViewController=navController;
    NSLog(@"%@",NSStringFromSelector(_cmd));
        [self.window makeKeyAndVisible];}
    return YES;
}

//该方法会在状态恢复触发之前被调用，把设置UIWindow的代码移到这里来
-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


//当用户点击home键返回到主界面的时候，需要触发保存方法saveChange：
- (void)applicationDidEnterBackground:(UIApplication *)application {

    bool success=[[ItemStore sharedStore]saveChanges];
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
