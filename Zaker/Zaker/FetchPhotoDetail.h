//
//  FetchPhotoDetail.h
//  Zaker
//
//  Created by Mia on 15/11/22.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FetchPhotoDetail : UIViewController
@property(nonatomic,strong)NSArray *UrlOfAllPhoto;
@property(nonatomic,strong)NSString *TitleOfAllPhoto;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)NSMutableArray *slideImages;
@property (strong,nonatomic)UIPageControl *pageControl;


@end
