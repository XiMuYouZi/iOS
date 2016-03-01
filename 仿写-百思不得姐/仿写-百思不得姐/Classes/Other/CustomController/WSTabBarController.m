//
//  WSTabBarController.m
//  仿写-百思不得姐
//
//  Created by Mia on 16/2/28.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "WSTabBarController.h"
#import "WSEssenceViewController.h"
#import "WSNewViewController.h"
#import "WSMeViewController.h"
#import "WSFriendTrendViewController.h"
#import "WSTabBar.h"
#import "WSNavigationController.h"


@interface WSTabBarController ()

@end

@implementation WSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UINavigationBar appearance];

    
    NSMutableDictionary *attr=[NSMutableDictionary dictionary];
    attr[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    attr[NSForegroundColorAttributeName]=[UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs=[NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName]=[UIColor darkGrayColor];
    
    /*
    通过appearance统一设置所有UITabBarItem的文字属性
    后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    比如下面的方法setTitleTextAttributes：forstate：可以统一设置tabbaritem的文字在正常和被选中时的颜色
     同理有这样的方法的还有[UINavigationBar apperance];
     */
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
//    添加子控制器
    [self setupChildVc:[[WSEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[WSNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[WSFriendTrendViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[WSMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];

    
//    设置tabBar为自定义的WSTabBar
    [self setValue:[[WSTabBar alloc]init] forKeyPath:@"tabBar"];
}

//设置tabBar子控制器的属性
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *images=[UIImage imageNamed:selectedImage];
    
//    默认iOS会对高亮图片进行蓝色渲染，下面这句是让iOS保持图片的原型，不要蓝色渲染
//    也可以在ASSets中进行统一设置
    images=[images imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage =images;

    // 添加为子控制器
    
    WSNavigationController *nav=[[WSNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
