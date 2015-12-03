//
//  showPhotoWithModalView.h
//  Zaker
//
//  Created by Mia on 15/12/2.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "showPhotoWithCollectionView.h"

@interface showPhotoWithModalView : UIViewController

@property (nonatomic)showPhotoWithCollectionView *SHCV;
@property(nonatomic,strong)UIImage *image;
@property (nonatomic,strong)NSString *theURLofPhoto;
@property(nonatomic) UIImageView *imageView;

@end
