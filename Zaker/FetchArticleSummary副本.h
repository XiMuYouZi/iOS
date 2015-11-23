//
//  FetchArticleSummary.h
//  Zaker
//
//  Created by Mia on 15/11/18.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FetchArticleDetail;

@interface FetchArticleSummary : UITableViewController
@property (nonatomic)FetchArticleDetail *webViewController;
@property(nonatomic,copy)NSString *articleTitle;
@property(nonatomic,copy)NSString *theMagazineURL;
@property(nonatomic ,strong)NSString *theNameOfMagazine;


@end
