//
//  bannerCellModel+FetchPhoto.h
//  Tecent-cartoon
//
//  Created by Mia on 16/1/18.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "bannerCellModel.h"

//宏定义一个block
typedef void(^FetchPhotoBlock)(NSArray *cellContent);



@interface bannerCellModel (FetchPhoto)

//@property(nonatomic,copy) void(^FetchPhotoBlock)(NSArray *cellContent);

//暴露一个block接口给homepagecontroller,把数据传递给他
-(void)fetchBannerPhotos;
@end
