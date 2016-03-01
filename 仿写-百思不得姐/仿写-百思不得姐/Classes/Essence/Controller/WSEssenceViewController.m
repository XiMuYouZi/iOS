//
//  WSEssenceViewController.m
//  仿写-百思不得姐
//
//  Created by Mia on 16/2/28.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "WSEssenceViewController.h"

@interface WSEssenceViewController ()

@end

@implementation WSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 调用UIBarButtonItem+XMGExtension.h的类方法，设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.view.backgroundColor=WSGlobalBackgroundColor;
}


- (void)tagClick
{
    WSLogFunc;
}




@end
