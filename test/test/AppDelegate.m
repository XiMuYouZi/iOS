//
//  AppDelegate.m
//  test
//
//  Created by Mia on 16/1/22.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "nextViewController.h"

@interface AppDelegate ()
@property(nonatomic,strong)id observer;
@property(nonatomic,strong)id observer2;

@property(nonatomic,strong)NSArray *appStatus;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.observer=[[ViewController alloc]init];
    [self addObserver:self.observer forKeyPath:@"appStatus" options:NSKeyValueObservingOptionNew context:@"传递到viewcontroller"];
    
    
    self.observer2=[[nextViewController alloc]init];
    [self addObserver:self.observer forKeyPath:@"appStatus" options:NSKeyValueObservingOptionNew context:@"传递到buttonview"];
    

//    .运算符也会使用KVC设置值
    self.appStatus=@[@1,@2,@"233"];
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

//    使用KVC 机制设置值
    [self setValue:@"WillResign" forKey:@"appStatus"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    self.appStatus=@"didENterBack";

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    @try {
        [self removeObserver:self forKeyPath:@"appStatus"];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
