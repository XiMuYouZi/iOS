//
//  WSMeViewController.m
//  仿写-百思不得姐
//
//  Created by Mia on 16/2/28.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "WSMeViewController.h"

@interface WSMeViewController ()

@end

@implementation WSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"我的";
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems=@[settingItem,moonItem];
    
    self.view.backgroundColor=WSGlobalBackgroundColor;

    
}

-(void)settingClick
{
    WSLogFunc;
}

-(void)moonClick
{
    WSLogFunc;
}



@end
