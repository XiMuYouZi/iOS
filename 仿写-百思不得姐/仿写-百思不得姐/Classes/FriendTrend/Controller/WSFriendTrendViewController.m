//
//  WSFriendTrendViewController.m
//  仿写-百思不得姐
//
//  Created by Mia on 16/2/28.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "WSFriendTrendViewController.h"
#import "WSRecommendViewController.h"


@interface WSFriendTrendViewController ()

@end

@implementation WSFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 调用UIBarButtonItem+XMGExtension.h的类方法，设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    self.view.backgroundColor=WSGlobalBackgroundColor;

}

- (void)friendsClick
{
    [self.navigationController pushViewController:[[WSRecommendViewController alloc] init ]animated:YES];
}

@end
