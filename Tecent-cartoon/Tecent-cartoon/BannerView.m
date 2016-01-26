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
        [self configLayout];
    }

    return self;
}


-(void)configCell:(bannerCellModel *)cellmodel
{
    self.bannerImageView.image=cellmodel.Image;
}



-(UIScrollView *)scrollView
{
    
    [_scrollView setPagingEnabled:YES];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setScrollsToTop:NO];
    [_scrollView setDelegate:self];
    _scrollView.bounces = YES;
    
    return _scrollView;
}

-(UIPageControl*)pageControl
{
    _pageControl.currentPage=0;
    _pageControl.numberOfPages=5;
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [_pageControl setPageIndicatorTintColor:[UIColor blackColor]];
    
    return _pageControl;
}





-(void)configLayout
{
        
//布局scrollerview
    _scrollView =[[UIScrollView alloc]init];
    [self.contentView addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(750, 436));

    }];
    

    
//    布局_bannerImageView
    _bannerImageView=[[UIImageView alloc]init];
//    _bannerImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_bannerImageView];
    [_bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.and.right.equalTo(self.scrollView);


    }];
    
    
//    布局UIPageControl
    _pageControl=[[UIPageControl alloc]init];
    [self.bannerImageView addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-10);
        make.bottom.equalTo(self.contentView).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 20));

    }];
    
    
    [_bannerImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

@end
