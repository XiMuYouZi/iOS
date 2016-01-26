//
//  BannerView.h
//  Tecent-cartoon
//
//  Created by Mia on 16/1/17.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bannerCellModel.h"

@interface BannerView :UITableViewCell<UIScrollViewDelegate>
@property(strong ,nonatomic)UIImageView *bannerImageView;
@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)UIPageControl *pageControl;

-(void)configCell:(bannerCellModel *)cellmodel;

@end
