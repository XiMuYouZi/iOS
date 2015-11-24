//
//  FetchPhotoSummary.h
//  Zaker
//
//  Created by Mia on 15/11/23.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FetchPhotoSummary : UICollectionViewController
@property(nonatomic,copy)NSString *thePhotosURL;
@property(nonatomic ,strong)NSString *thePhotosNAME;
@property(nonatomic,strong)NSArray *allPhotos;
@property(nonatomic,strong)NSArray *allPhotosTitle;
@property(nonatomic,strong)NSString *urlOfThumbnails;


@end
