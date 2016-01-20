//
//  bannerCellModel+FetchPhoto.m
//  Tecent-cartoon
//
//  Created by Mia on 16/1/18.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "bannerCellModel+FetchPhoto.h"
#import "MKNetworkKit.h"

#define HomePageURL @"http://mobilev3.ac.qq.com/Home/homePageDetailForIosV3/uin/476301176/local_version/3.6.1/channel/1001/guest_id/5A056C3E-76B2-4168-A693-7B41A08D17B5"
#define banner_url @"data.banner.data"

@interface bannerCellModel ()
@property (nonatomic,strong)MKNetworkEngine *engine;
@end

@implementation bannerCellModel (FetchPhoto)

-(id)init
{
    self=[super init];
    if (self) {
    }
    
    return self;
}


//获取所有的json数据
-(void)fetchJsonData:(FetchPhotoBlock)completionBlock
{        MKNetworkEngine *engine=[[MKNetworkEngine alloc]init];

        MKNetworkOperation *operation = [engine operationWithURLString:HomePageURL];
        [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            NSLog(@"请求完成");
            NSDictionary *resultData=[[NSDictionary alloc]init];
            
            // 获得返回的数据（json形式）
             if ([completedOperation isCachedResponse])
             {
               resultData = [[completedOperation responseJSON] valueForKey:@"data"];
             }
            
#warning 这里非常重要，因为是请求是异步操作，所以必须在block内部返回值，可以使用bloc，notification，delegate
//            如果有人调用了这个block，就给它传递值
            if (completionBlock) {
                completionBlock([resultData copy]);
            }
    
    
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"请求出错");
    
        }];
    
        // 发起网络请求
    [self.engine useCache];

        [self.engine enqueueOperation:operation];
}



//下载图片
-(void)fetchPhoto:(NSURL *)imageURL imageIndex:(NSInteger)index
{
    //获取Documents路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *storgeImagePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"banner_image_%ld.png", (long)index]];
    
    MKNetworkOperation *op=[self.engine imageAtURL:imageURL completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        NSData *data = [NSData dataWithData:UIImagePNGRepresentation(fetchedImage)];
        [data writeToFile:storgeImagePath atomically:YES];
        

    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"无法下载图片");
    }];
    
    
    [self.engine enqueueOperation:op];
    
}



//暴露一个block接口给homepagecontroller,把banner的photo传递给它
+(void)fetchBannerPhotos:(FetchPhotoBlock)completionBlock
{

    MKNetworkEngine *engine=[[MKNetworkEngine alloc]init];
    MKNetworkOperation *operation = [engine operationWithURLString:HomePageURL];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
        
            NSDictionary *resultData=[[NSDictionary alloc]init];
            NSMutableArray *cellModelData=[[NSMutableArray alloc]init];
        
            resultData = [[completedOperation responseJSON] valueForKeyPath:banner_url];
   
            
            for (NSDictionary *bannerURLS in resultData)
            {
                bannerCellModel *cellmodel=[[bannerCellModel alloc]init];
                NSString *bannerUrl=[bannerURLS valueForKey:@"banner_url"];
                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:bannerUrl]];
                cellmodel.Image= [UIImage imageWithData:data];
                [cellModelData addObject:cellmodel];
                
            }
        
        if (completionBlock)
        {
            NSLog(@"block:%@",cellModelData);
            completionBlock([cellModelData copy]);
        }
            
       }
     
        errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
         {
        NSLog(@"请求出错");

         }
      ];
        
        
        [engine useCache];
        [engine enqueueOperation:operation];

       
    
}


@end
