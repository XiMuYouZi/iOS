//
//  fetchHomePageJsonData.h
//  Tecent-cartoon
//
//  Created by Mia on 16/1/18.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^FetchBannerUrlBlock)(NSDictionary *bannerURL);

@interface fetchHomePageJsonData : NSObject

@property(nonatomic,strong)NSDictionary *resultData;
-(void)fetchJsonData;


@end
