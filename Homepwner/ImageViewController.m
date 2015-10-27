//
//  ImageViewController.m
//  Homepwner
//
//  Created by Mia on 15/10/26.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

-(void)loadView
{
//    创建用于显示点击缩略图后显示大尺寸照片的UIViewController对象
    UIImageView * imageView=[[UIImageView alloc]init];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.view=imageView;
}

//将相应地UIImage对象赋给image属性，在viewwillappear中把image显示到UIImageView中
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    将view转换为UIImageView对象，以便向其发送setimage消息：
    UIImageView *imageview=(UIImageView *)self.view;
    imageview.image=self.image;
}
@end
