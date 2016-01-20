//
//  nextpage.m
//  test
//
//  Created by Mia on 16/1/19.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "nextpage.h"
#import "MKNetworkKit.h"



#define banner_url @"data.banner.data"

#define host @"mobilev3.ac.qq.com"
#define path  @"Home/homePageDetailForIosV3/uin/476301176/local_version/3.6.1/channel/1001/guest_id/5A056C3E-76B2-4168-A693-7B41A08D17B5"
@implementation nextpage





static id _instance;

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self getBannerPhotoURL];
    NSLog(@"viewdidlog:%@",self.resultData);

}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"bannerURLsss:%@",self.resultData);
}

#pragma  mark - 获取数据
-(void)fetchJsonData
{
    NSLog(@"block之前");
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:host  customHeaderFields:nil];
    MKNetworkOperation *operation = [engine operationWithPath:path];

[operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"请求完成");
    
    NSDictionary * resultDatas = [completedOperation responseJSON];

        // 获得返回的数据（json形式）
    if (self.passdata) {
        self.passdata(resultDatas);
    }
    
    
    
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"请求出错");
        
    }];
    
    // 发起网络请求
    [engine enqueueOperation:operation];
    
    
}

#pragma mark - 获取banner_url
-(void)getBannerPhotoURL
{
    __block NSDictionary *data=[[NSDictionary alloc]init];
    
    [self fetchJsonData];
    self.passdata=^(NSDictionary *dic){
        _resultData =dic;
    };
    NSLog(@"gethou%@",data);
    
    
}

//-(void)fetch
//{
//    [self getBannerPhotoURL:^(NSDictionary *data) {
//        _resultData=data ;
//    }];
//}
@end
