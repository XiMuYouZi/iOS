//
//  FetchPhotoDetail.m
//  Zaker
//
//  Created by Mia on 15/11/22.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "FetchPhotoDetail.h"

@interface FetchPhotoDetail ()<UIScrollViewDelegate>
@property (nonatomic,strong )UIImage *image;
//@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)NSString *urlOfPhoto;
@end

@implementation FetchPhotoDetail


- (IBAction)SwitchPhoto:(UISwipeGestureRecognizer *)sender
{
        
}

-(void)viewDidLoad

{
//    NSLog(@"urlofAllPhoto:%@",self.UrlOfAllPhoto);
    [super viewDidLoad];
    [self.scrollView setPagingEnabled:YES];
    [self getPhoto:self.urlOfPhoto];
    self.navigationItem.title=self.TitleOfAllPhoto;

//    [self.scrollView addSubview:self.imageView];
}


-(void)setUrlOfAllPhoto:(NSArray *)UrlOfAllPhoto
{
    [self.spinner startAnimating];

    _UrlOfAllPhoto=UrlOfAllPhoto;
    self.urlOfPhoto=self.UrlOfAllPhoto[arc4random()%[UrlOfAllPhoto count]];

//    NSLog(@"urlofPhoto:%@",self.urlOfPhoto);
}


-(void) getPhoto:(NSString *)fileURL {

    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
//    dispatch_queue_t fetchQ=dispatch_queue_create("fetch photo", NULL);
#warning 主队列被阻塞，需要等到所有图片都下载完毕，才会显示cell
    self.image = [UIImage imageWithData:data];
//    self.imageView.frame=CGRectMake(0,0, self.image.size.width, self.image.size.height);
    self.imageView.image=self.image;

    
}
//
//-(void)setImage:(UIImage *)image
//{
//    self.imageView.image=image;
////    [self.imageView sizeToFit];
//#warning 的左上角不在imageview的左上角
////    self.imageView.frame=CGRectMake(0,0, image.size.width, image.size.height);
//
//    self.scrollView.contentSize=self.image ? self.image.size:CGSizeZero;
// 
//    
//    [self.spinner stopAnimating];
//}
//
//-(UIImage *)image
//{
//    return self.imageView.image;
//}

-(void)setScrollView:(UIScrollView *)scrollView
{
//    self.imageView.frame=CGRectMake(0,0, self.image.size.width, self.image.size.height);
    _scrollView=scrollView;
    _scrollView.minimumZoomScale=1.0;
    _scrollView.maximumZoomScale=1.0;
    _scrollView.delegate=self;
    
    self.scrollView.contentSize=self.image ? self.image.size:CGSizeZero;
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
//    [self.imageView sizeToFit];
//self.imageView.frame=CGRectMake(0,0, self.image.size.width, self.image.size.height);
    return self.imageView;
}




@end
