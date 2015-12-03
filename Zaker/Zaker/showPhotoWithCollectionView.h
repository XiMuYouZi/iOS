//
//  showPhotoWithCollectionView.h
//  Zaker
//
//  Created by Mia on 15/12/2.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAMCollectionViewFlemishBondLayout.h"
#import "FetchPhotoSummary.h"


@protocol showPhotoWithCollectionViewDelegate <NSObject>

-(void)getURLofPhoto:(NSArray *)URLofALLphoto atIndexPath:(NSIndexPath *)indexPath;

@end


@interface showPhotoWithCollectionView : UIViewController <FetchArticleSummaryDelegte,UICollectionViewDataSource,UIBarPositioningDelegate,RAMCollectionViewFlemishBondLayoutDelegate>
@property(nonatomic,weak) id<showPhotoWithCollectionViewDelegate>delegates;

@end
