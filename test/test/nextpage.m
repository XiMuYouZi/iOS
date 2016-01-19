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
    NSLog(@"bannerURL:%@",self.resultData);

}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"bannerURLsss:%@",self.resultData);
}

#pragma  mark - 获取数据
-(void)fetchJsonData
{
//    NSLog(@"block之前");
//    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:host  customHeaderFields:nil];
//    MKNetworkOperation *operation = [engine operationWithPath:path];
////    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_async (dispatch_get_main_queue(), ^{
//[operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
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
//    });
//    
//    // 发起网络请求
//    [engine enqueueOperation:operation];
    
    NSURL *url = [NSURL URLWithString:@"http://mobilev3.ac.qq.com/Home/homePageDetailForIosV3/uin/476301176/local_version/3.6.1/channel/1001/guest_id/5A056C3E-76B2-4168-A693-7B41A08D17B5"];
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                             timeoutInterval:10];
    //第三步，连接服务器,发送同步请求
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    _resultData=[NSJSONSerialization JSONObjectWithData:received options:NSUTF8StringEncoding error:nil];
    
}

#pragma mark - 获取banner_url
-(void)getBannerPhotoURL
{
    
[self fetchJsonData];
    
    
}
@end
