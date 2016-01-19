//
//  ViewController.m
//  test
//
//  Created by Mia on 16/1/19.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "ViewController.h"
#import "MKNetworkKit.h"

@interface ViewController ()

@end


#define banner_url @"data.banner.data"

#define host @"mobilev3.ac.qq.com"
#define path  @"Home/homePageDetailForIosV3/uin/476301176/local_version/3.6.1/channel/1001/guest_id/5A056C3E-76B2-4168-A693-7B41A08D17B5"


@implementation ViewController

static id _instance;

//-(void)viewDidLoad
//{
//    [super viewDidLoad];
//    [self getBannerPhotoURL];
//}


//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    NSLog(@"bannerURLsss:%@",self.resultData);
//}
//
//#pragma  mark - 获取数据
//-(void)fetchJsonData
//{
//    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:host  customHeaderFields:nil];
//    MKNetworkOperation *operation = [engine operationWithPath:path];
//    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//        NSLog(@"请求完成");
//        
//        // 获得返回的数据（json形式）
//        _resultData = [completedOperation responseJSON];
//        
//        
//    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//        NSLog(@"请求出错");
//        
//    }];
//    
//    // 发起网络请求
//    [engine enqueueOperation:operation];
//    
//}
//
//#pragma mark - 获取banner_url
//-(void)getBannerPhotoURL
//{
//    [self fetchJsonData];
//    sleep(5);
//    NSLog(@"bannerURL:%@",self.resultData);
//    
//}
@end
