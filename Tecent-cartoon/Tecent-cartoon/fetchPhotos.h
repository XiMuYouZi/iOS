//
//  fetchPhotos.h
//  Tecent-cartoon
//
//  Created by Mia on 16/1/18.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "fetchHomePageJsonData.h"

@interface fetchPhotos :fetchHomePageJsonData
@property(nonatomic,strong)NSDictionary *resultData;


-(NSArray *)getBannerPhotoURL;
+ (instancetype)sharedInstance;

@end
