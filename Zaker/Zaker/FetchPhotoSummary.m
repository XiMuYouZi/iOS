//
//  FetchPhotoSummary.m
//  Zaker
//
//  Created by Mia on 15/11/23.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "FetchPhotoSummary.h"
#import "FetchPhotoCell.h"
#import "FetchPhotoDetail.h"
#import "showPhotoWithCollectionView.h"



@interface FetchPhotoSummary ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic)FetchPhotoDetail *fetchPhotoDetail;
@property(nonatomic)showPhotoWithCollectionView *showphoto;
@end



@implementation FetchPhotoSummary
#define ALL_PHOTOS @"showapi_res_body.pagebean.contentlist"
#define ALL_PHOTOS_URL @"list"
#define ALL_PHOTOS_TITLE @"title"
#define BIG_PHOTO @"big"
#define MEDIUM_PHOTO @"middle"


static NSString * const reuseIdentifier = @"the photo of magazine";

-(void)DisplaySummaryPhoto:(NSArray *)AllPhotos  atIndexPath:(NSIndexPath *)indexpath
{
    
self.urlOfThumbnails=[[AllPhotos valueForKeyPath:ALL_PHOTOS_URL][indexpath.row] valueForKeyPath:MEDIUM_PHOTO][0];

}




-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_delegate respondsToSelector:@selector(getAllPhotos:atIndexPath:)])
    {

        [_delegate getAllPhotos:self.allPhotos atIndexPath:indexPath];
    }

}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show detailPhoto"])
    {
        
#warning 一定要记得设置代理！！！！！
        _delegate=segue.destinationViewController;
        
        NSIndexPath *indexPath=[self.collectionView indexPathForCell:sender];
        if ([_delegate respondsToSelector:@selector(getAllPhotos:atIndexPath:)])
        {
            [_delegate getAllPhotos:self.allPhotos atIndexPath:indexPath];
        }

    }
}



/*stanford 老头用的这个方法下载的图片，我这里不行
覆盖ImageURL的getter的方法，设置image属性为通过imageURL这个URL下载下来的图片
-(void)setUrlOfThumbnails:(NSString *)urlOfThumbnails
{
    _urlOfThumbnails=urlOfThumbnails;
    [self startDownloadingImage];
}


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

*/




-(void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchPhoto];
    self.navigationItem.title=self.thePhotosNAME;


}


//下载图片
-(void) getImageFromURL:(NSString *)fileURL {
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    /*使用下面这种写法，把获取图片的方法放到自己创建的一个队列里面，会出现第一个cell是空白的情况，原因不明
    dispatch_queue_t fetchQ=dispatch_queue_create("fetch photo", NULL);
    dispatch_async(fetchQ, ^{self.image = [UIImage imageWithData:data];
     }); */
    self.image = [UIImage imageWithData:data];
    
}

//获取json数据
-(void)fetchPhoto
{
        NSURL *url = [NSURL URLWithString: self.thePhotosURL];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
        [request setHTTPMethod: @"GET"];
        [request addValue: @"fefa4eb543425fc64ab767f301d934ad" forHTTPHeaderField: @"apikey"];
        [NSURLConnection sendAsynchronousRequest: request
                                           queue: [NSOperationQueue mainQueue]
                               completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                                   if (error) {
                                       NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                                   } else {
                                       
                                       NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
                                       self.allPhotos=[json  valueForKeyPath:ALL_PHOTOS];
                                       
                                       
//                                       NSLog(@"articles:%@",self.allPhotos);
                                       
                                       dispatch_async(dispatch_get_main_queue(), ^
                                                      {
                                                          [self.collectionView reloadData];
                                                          
                                                      });

                                       
                                       
                                       
                                       
                                       
                                   }
                               }];
    
    }
    


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.allPhotos count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    FetchPhotoCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [self DisplaySummaryPhoto:self.allPhotos atIndexPath:indexPath];
    [self getImageFromURL:self.urlOfThumbnails];

    cell.PhotoImageView.image=self.image;
    cell.layer.borderWidth=0.3f;
    cell.layer.borderColor=[UIColor grayColor].CGColor;
    cell.layer.cornerRadius=8;

    return  cell;
        
    }



@end
