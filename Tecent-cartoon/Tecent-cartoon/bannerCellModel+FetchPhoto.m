//
//  bannerCellModel+FetchPhoto.m
//  Tecent-cartoon
//
//  Created by Mia on 16/1/18.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "bannerCellModel+FetchPhoto.h"
#import "MKNetworkKit.h"
#import "HomePageController.h"



#define HomePageURL @"http://mobilev3.ac.qq.com/Home/homePageDetailForIosV3/uin/476301176/local_version/3.6.1/channel/1001/guest_id/5A056C3E-76B2-4168-A693-7B41A08D17B5"
#define banner_url @"data.banner.data"



@interface bannerCellModel ()
@property (nonatomic,strong)MKNetworkEngine *engine;
@property(nonatomic,strong)HomePageController *observer;
@property(nonatomic,strong)NSArray *cellModelDatas;
@end



@implementation bannerCellModel (FetchPhoto)


-(instancetype)init
{
    self=[super init];
    if (self) {
        self.observer=[HomePageController new];
          [self addObserver:self.observer forKeyPath:@"cellModelDatas" options:NSKeyValueObservingOptionNew context:@"传递cellModelData"];
    }
    return self;
    
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
-(void)fetchBannerPhotos
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
                self.cellModelDatas=cellModelData;

                
            }

         
//         使用notification传值
         
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"dataLoaded" object:self userInfo:[NSDictionary dictionaryWithObject:cellModelData forKey:@"json"]];
         
         
/*      使用KVO传值
         observer：观察者，需要响应属性变化的对象。该对象必须实现 observeValueForKeyPath:ofObject:change:context: 方法。
         keyPath：要观察的属性名称。要和属性声明的名称一致。
         options：对KVO机制进行配置，修改KVO通知的时机以及通知的内容，在后面详解。
         context：接收一个C指针，指向希望监听的属性。如：&self->_testData
 */
         
         

         
         
         
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
