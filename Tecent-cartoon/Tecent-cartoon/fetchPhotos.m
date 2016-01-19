//
//  fetchPhotos.m
//  Tecent-cartoon
//
//  Created by Mia on 16/1/18.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "fetchPhotos.h"
#import "MKNetworkKit.h"

@interface fetchPhotos ()
@end


#define banner_url @"data.banner.data"



@implementation fetchPhotos

static id _instance;


#pragma mark - 共享单例
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone{
    return _instance;
}




#pragma mark - 获取banner_url
-(NSArray *)getBannerPhotoURL
{
    [self fetchJsonData];
    NSArray  *bannerPhotoURL=[self.resultData valueForKeyPath:banner_url];
//    NSLog(@"%@",bannerPhotoURL);
    return bannerPhotoURL;
    
}

@end
