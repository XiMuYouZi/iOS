//
//  fetchHomePageJsonData.m
//  Tecent-cartoon
//
//  Created by Mia on 16/1/18.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "fetchHomePageJsonData.h"
#import "MKNetworkKit.h"


#define host @"mobilev3.ac.qq.com"
#define path  @"Home/homePageDetailForIosV3/uin/476301176/local_version/3.6.1/channel/1001/guest_id/5A056C3E-76B2-4168-A693-7B41A08D17B5"

@implementation fetchHomePageJsonData

-(void)fetchJsonData
{
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
    
    
    NSURL *url = [NSURL URLWithString:@"http://mobilev3.ac.qq.com/Home/homePageDetailForIosV3/uin/476301176/local_version/3.6.1/channel/1001/guest_id/5A056C3E-76B2-4168-A693-7B41A08D17B5"];
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                             timeoutInterval:10];
    //第三步，连接服务器,发送同步请求
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    _resultData=[NSJSONSerialization JSONObjectWithData:received options:NSUTF8StringEncoding error:nil];

    
}
@end
