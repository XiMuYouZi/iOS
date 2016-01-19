//
//  FetchPhotoDetail.m
//  Zaker
//
//  Created by Mia on 15/11/22.
//  Copyright (c) 2015年 Mia. All rights reserved.
//


/*
 本类使用UIscrollerview轮播显示图片，在这个项目里面不用了，目前采用的是collectionview显示图片
 */

#import "FetchPhotoDetail.h"


@interface FetchPhotoDetail ()<UIScrollViewDelegate>
{
    
}

@property (nonatomic)CGFloat width;
@property (nonatomic)CGFloat height;


@property (nonatomic,strong )UIImage *image;
@property (nonatomic,strong )UIImageView *imageView;

@property(nonatomic,strong)NSString *urlOfPhoto;
@property(nonatomic,strong)NSMutableArray *viewController;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)NSMutableArray *allImage;
@end

@implementation FetchPhotoDetail


#pragma mark -异常分析

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];//得到当前调用栈信息
    NSString *reason = [exception reason];//非常重要，就是崩溃的原因
    NSString *name = [exception name];//异常类型
    
    NSLog(@"exception type : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr);
}

#pragma mark -viewDidLoad

-(void)viewDidLoad

{
    [super viewDidLoad];
    
    [self fetchAllImage];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(120,580,100,18)]; // 初始化mypagecontrol


    self.navigationItem.title=self.TitleOfAllPhoto;

    [_scrollView setPagingEnabled:YES];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setScrollsToTop:NO];
    [_scrollView setDelegate:self];
    _scrollView.bounces = YES;

    
    _pageControl.currentPage=0;
    _pageControl.numberOfPages=[self.allImage count];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [_pageControl setPageIndicatorTintColor:[UIColor blackColor]];
    [_pageControl addTarget:self action:@selector(changeCurrentPage:) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件

    [self.view addSubview:_scrollView];
    [self.view addSubview:_pageControl];

    
#warning 加载所有的图片到内存会增加内存的使用，使用NSNull
//    把所有的image都放到scrollview中，上述所使用的方式是一次產生所有的 SubView， 並將它們全部丟入 UIScrollView 中，這樣的方法雖然相當方便也容易理解，但是如果你的 UIScrollView  內容過於龐大複雜時，卻很容易占用過多的資源，一個比較好的方法是，建立一個 NSMutableArray 來存放這些 UIView 的 UIViewController，並且使用 [NSNull null] 來做暫時的初始化，等到 UIView  真的要顯示時才去產生它。
    for (int i = 0;i<[_allImage count];i++)
    {
#warning 妈蛋啊，原来果然是这里出了问题，图片模式必须是这个模式，不然会出现一个屏幕显示两张不完整的图片，但是每个图集的第一张图片显示有问题。
        _imageView.contentMode=UIViewContentModeScaleAspectFit;
        _imageView = [[UIImageView alloc] initWithImage:[_allImage objectAtIndex:i]];
        _imageView.frame = CGRectMake((_scrollView.frame.size.width * i) , 0, _scrollView.frame.size.width, self.view.frame.size.height);
        [_scrollView addSubview:_imageView];
    }
    
    
//    设置contentsize和初始的contentOffset
    self.scrollView.contentSize= CGSizeMake(_scrollView.frame.size.width*([self.allImage count]+2),_scrollView.frame.size.height);
    [_scrollView setContentOffset:CGPointMake(0, 0)];

    
}




#pragma mark - scrollview委托事件：滚动到下一张图片

//在這個部分我們將會實作 <UIScrollViewDelegate> 協定中的方法函式 scrollViewDidScroll:，來將目前 UIScrollView 所捲動的位移量換算成 UIPageControl 的頁數。
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat width = _scrollView.frame.size.width;
//    图片滑到中间位置就跳到下一张图片
    NSInteger currentPage = floor((self.scrollView.contentOffset.x - width/([_allImage count]+2))/width)+1;
    [_pageControl setCurrentPage:currentPage];

}


//在這部分我們會透過一個自定義的方法函式 changeCurrentPage: 來將 UIPageControl 的頁數換算成 UIScrollView 的位移量，並且讓 UIScrollView 使用動畫的方式捲動過去，你可以將此方法函式與 UIPageControl 中的 Value Changed 事件做連結，這樣每當使用者操作 UIPageControl 改變頁數時，就會呼叫此函式並實作裡面的方法。

- (void)changeCurrentPage:(UIPageControl *)sender
{
    NSInteger page = _pageControl.currentPage;
    CGFloat width, height;
    width = _scrollView.frame.size.width;
    height = _scrollView.frame.size.height;
    CGRect frame = CGRectMake(width*page, 0, width, height);
    [_scrollView scrollRectToVisible:frame animated:YES];

}



#pragma mark - 设置和获取照片
-(UIImage *) getPhoto:(NSString *)fileURL {
    
#warning 主队列被阻塞，需要等到所有图片都下载完毕，才能进行其他操作
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    self.image = [UIImage imageWithData:data];
    return [UIImage imageWithData:data];
    

    
}




-(void)setImage:(UIImage *)image
{
    _image=image;
    _imageView.image=self.image;
    
}


-(void)fetchAllImage
{
#warning 使用数字字典之前一定要初始化啊
    self.allImage   =[[NSMutableArray alloc]init];
    for (NSInteger i=0;i<[self.UrlOfAllPhoto count];i++) {
        NSString *url=self.UrlOfAllPhoto[i];
        [self.allImage addObject:[self getPhoto:url]];
        
        
    }
    
}


#pragma mark - scrollview委托事件：设置照片的缩放功能

-(void)setScrollView:(UIScrollView *)scrollView
{
//    self.imageView.frame=CGRectMake(0,0, self.image.size.width, self.image.size.height);
    _scrollView=scrollView;
    _scrollView.minimumZoomScale=0.5;
    _scrollView.maximumZoomScale=2.0;
    _scrollView.delegate=self;
    

    self.scrollView.contentSize=self.image ? CGSizeMake(_scrollView.frame.size.width*[self.allImage count],_scrollView.frame.size.height):CGSizeZero;

}



-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}








@end
