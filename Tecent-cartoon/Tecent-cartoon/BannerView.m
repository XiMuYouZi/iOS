//
//  BannerView.m
//  Tecent-cartoon
//
//  Created by Mia on 16/1/17.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "BannerView.h"
#import "Masonry.h"

@implementation BannerView


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayout];
    }

    return self;
}


//暴露了一个接口给homepagecontroller来实现配置bannerView的数据显示
-(void)configCell:(bannerCellModel *)cellmodel
{
    self.bannerImageView.image=cellmodel.Image;
}



//配置cell内部的各个控件的autolayout
-(void)initLayout
{
        
//布局scrollerview
    _scrollview =[[UIScrollView alloc]init];
    [self.contentView addSubview:_scrollview];
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(750, 436));

    }];
    

    
//    布局_bannerImageView
    _bannerImageView=[[UIImageView alloc]init];
//    _bannerImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_bannerImageView];
    [_bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.and.right.equalTo(self.scrollview);


    }];
    
    
//    布局UIPageControl
    _pagecontrol=[[UIPageControl alloc]init];
    [self.bannerImageView addSubview:_pagecontrol];
    [_pagecontrol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-10);
        make.bottom.equalTo(self.contentView).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 20));

    }];
    
    
    [_bannerImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

@end
