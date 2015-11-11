//
//  JustPostedFlickPhotoTVC.m
//  Shutterbug
//
//  Created by Mia on 15/11/11.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "JustPostedFlickPhotoTVC.h"
#import "FlickrFetcher.h"

@interface JustPostedFlickPhotoTVC ()

@end

@implementation JustPostedFlickPhotoTVC



-(void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchPhotos];
}


//实现下拉tableviewcontroller刷新列表，同时把获取照片url的操作放到自定义的队列，这样就不会阻塞main queue
- (IBAction)fetchPhotos {
    [self.refreshControl beginRefreshing];
    
//    调用FlickrFetcher的方法获取照片的url地址
    NSURL *url=[FlickrFetcher URLforRecentGeoreferencedPhotos];
    
//    创建一个串行队列，名字叫flicker fetcher，NULL表示串行
    dispatch_queue_t fetchQ=dispatch_queue_create("flicker fetcher", NULL);
    
//    在自定义队列中获取url对应的照片信息
    dispatch_async(fetchQ, ^{
        
//    获取该url地址的json数据
        NSData *jsonResults=[NSData dataWithContentsOfURL:url];
        
//    把json数据进行字典化
        NSDictionary *propertyListResults=[NSJSONSerialization JSONObjectWithData:jsonResults
                                                                          options:0
                                                                            error:NULL];
        NSLog(@"json：%@",propertyListResults);
        
//    调用flickrFetch中的定义的宏命令，photos.photo表示在photos字典中的photo键对应的值，下面是寻找propertyListResults字典中的photos字典中的键为photo对应的值
        NSArray *photos=[propertyListResults valueForKey:FLICKR_RESULTS_PHOTOS];
        
//        显示照片的操作需要更新界面，所以放在main queue中操作
        dispatch_async(dispatch_get_main_queue(), ^{
            
//    隐藏小转轮
            [self.refreshControl endRefreshing];
            self.photos=photos;});
        });
}



@end
