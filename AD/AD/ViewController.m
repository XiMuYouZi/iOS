//
//  ViewController.m
//  AD
//
//  Created by Mia on 15/12/24.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ViewController.h"
#import <iAD/iAD.h>

@interface ViewController ()<ADBannerViewDelegate>
@property(nonatomic,strong)ADBannerView *bannerView;

@end

@implementation ViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.bannerView=[[ADBannerView alloc]initWithAdType:ADAdTypeBanner];
    self.bannerView.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    self.bannerView.delegate=self;
    [self.view addSubview:self.bannerView];
    int i=0;
    for (; i<10; i++) {
        int b=i*i;
        NSLog(@"%i",b);
    }
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"广告加载成功");
    
}




-(void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    NSLog(@"广告关闭");
}
@end
