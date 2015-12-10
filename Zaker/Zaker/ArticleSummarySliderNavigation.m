//
//  ArticleSummarySliderNavigation.m
//  Zaker
//
//  Created by Mia on 15/12/10.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ArticleSummarySliderNavigation.h"
#import "FetchArticleSummary.h"

@interface ArticleSummarySliderNavigation ()

@end

@implementation ArticleSummarySliderNavigation

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSArray *viewControllerClasses = @[[FetchArticleSummary class], [FetchArticleSummary class], [FetchArticleSummary class]];
        NSArray *titles = @[@"社会新闻", @"科技新闻", @"体育新闻"];
        self.viewControllerClasses = viewControllerClasses;
        self.titles = titles;
        self.titleColorSelected=[UIColor colorWithRed:240/255 green:248/255 blue:255/255 alpha:1.0];
        
        self.menuItemWidth = 60;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleSizeSelected = 15.0;
        self.keys=@[@"theMagazineURL",@"theMagazineURL",@"theMagazineURL",];
        self.values= @[
                       [NSString stringWithFormat:@"http://apis.baidu.com/txapi/social/social?num=20&page=%d",arc4random()%10],
                       [NSString stringWithFormat:@"http://apis.baidu.com/txapi/keji/keji?num=20&page=%d",arc4random()%10],
                       [NSString stringWithFormat:@"http://apis.baidu.com/txapi/tiyu/tiyu?num=20&page=%d",arc4random()%10]];
        

    }
    return self;
}


@end
