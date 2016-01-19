//
//  bannerCellModel+FetchPhoto.m
//  Tecent-cartoon
//
//  Created by Mia on 16/1/18.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "bannerCellModel+FetchPhoto.h"
#import "fetchPhotos.h"


@implementation bannerCellModel (FetchPhoto)


//暴露一个block接口给homepagecontroller,把banner的photo传递给它
+(void)fetchBannerPhotos:(FetchPhotoBlock)completionBlock
{
    
    NSArray *allJsonData=[[NSArray alloc]init];
    NSMutableArray *cellModels=[NSMutableArray new];

    //    获取banner_url
    allJsonData=[[[fetchPhotos sharedInstance]getBannerPhotoURL]copy];

    for (NSDictionary *bannerURLS in allJsonData) {
        bannerCellModel *cellModel=[[bannerCellModel alloc]init];
        NSString *banner_url=[bannerURLS valueForKey:@"banner_url"];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:banner_url]];
        cellModel.Image= [UIImage imageWithData:data];
        [cellModels addObject:cellModel];


    }
    
//    使用block属性传递数据到HomePageController，传递的数据就是mutableArray
    if (completionBlock) {
        completionBlock([cellModels copy]);
//        NSLog(@"%@",cellModels);

    }
    
}


@end
