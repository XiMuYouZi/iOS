//
//  ImageViewController.m
//  Imagination
//
//  Created by Mia on 15/11/10.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImage *image;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ImageViewController


//惰性实例化imageView
-(UIImageView *)imageView
{
    if (!_imageView) _imageView=[[UIImageView alloc]init];
    return _imageView;
}



-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView    addSubview:self.imageView];
}


//覆盖ImageURL的getter的方法，设置image属性为通过imageURL这个URL下载下来的图片
-(void)setImageURL:(NSURL *)imageURL
{
    _imageURL=imageURL;
//    self.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
    [self startDownloadingImage];
}


//解决网络下载造成的main queue阻塞问题，因为网络下载需要等待，如果放在主线程中执行，就会导致在等待内容下载完成之前是无法完成其他操作的
//所以把下载进程放到后台，下载完了在回调到主线程中
-(void)startDownloadingImage
{
    self.image=nil;
    [self.spinner startAnimating];
    if (self.imageURL) {
        NSURLRequest *request=[NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration =[NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session=[NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task=[session downloadTaskWithRequest:request
                                                      completionHandler:^(NSURL *loaclfile, NSURLResponse *response, NSError *error) {
                                                          if (!error) {
//  保证在下载过程中URL不被修改因为如果下载需要10min，等待期间用户又点击了其他链接，如果不写这一句，会导致最后下载下来的内容和刚开始第一次点击的下载链接下载的内容是不同的
                                                              if ([request.URL isEqual:self.imageURL]) {
                                                                  UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:loaclfile]];
                                                                  dispatch_async(dispatch_get_main_queue(), ^{self.image=image;});
                                                              }
                                                          }
                                                      }];
        [task resume];
    }
}



//  1、首先执行viewController的prepareforSegue方法，但是这个时候还没有设置好outlet，也就是还没有设置好imageview。
//    2、但是在该方法中设置了imageURL，触发setImageURL方法，该方法设置了image，触发setImage方法，在此处设置contentsize，但是此时imageview还没有设置好，所以无法设置contentsize。
//    3、最后系统才会设置scrollview，此时触发setScrollView，这个时候才可以正确设置contentsize。

-(void)setImage:(UIImage *)image
{
    self.imageView.image=image;   //把self的image属性赋给imageviwe的image属性
    [self.imageView sizeToFit];   //image填充整个imageview

//  第一处（这里可以不用设置，使用第二处可以正常设置scrollview的contentsize）
//   如果下载了图片，那么contentsize的大小就是image的size大小，否则就设置contentsize的大小为0，0
//   self.scrollView.contentSize=self.image ? self.image.size:CGSizeZero;
    [self.spinner stopAnimating];

}


//下面两个方法使用UIScrollView的委托方法实现缩放功能
-(void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView=scrollView;
    _scrollView.minimumZoomScale=0.2;
    _scrollView.maximumZoomScale=2.0;
    _scrollView.delegate=self;
//  第二处（只有此时scrollview才会被创建，也只有在此处设置contentsize才是有效的）
//   如果下载了图片，那么contentsize的大小就是image的size大小，否则就设置contentsize的大小为0，0
    self.scrollView.contentSize=self.image ? self.image.size : CGSizeZero;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}




//设置image的getter和setter，但是这里没有使用@synthesize，因为没有使用实例变量_image,而是使用另外一个对象来定义image的
-(UIImage *)image
{
    return self.imageView.image;  //返回imageview的image属性
}



@end
