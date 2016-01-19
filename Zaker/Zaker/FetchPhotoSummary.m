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
@property(nonatomic,strong)NSString *data;
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





-(void)viewDidLoad
{
    [super viewDidLoad];
   NSLog(@"viewdidload:%@",self.allPhotos);
    [self fetchPhoto];

    self.navigationItem.title=self.thePhotosNAME;


}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    NSLog(@"viewWilldisappear:%@",self.allPhotos);

    
}


//下载图片
-(void) getImageFromURL:(NSString *)fileURL cells:(FetchPhotoCell *)cell {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^
                   {
//                       在global线程中下载图片
                       NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
                       self.image = [UIImage imageWithData:data];
                       
//                       在main线程中更新cell的imageview图像
                       dispatch_async(dispatch_get_main_queue(), ^{
                           cell.PhotoImageView.image=self.image;
                       });
                   
                   });

}

//获取json数据
-(void)fetchPhoto
{
    NSLog(@"block之前");
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
                                       self.allPhotos=[NSArray new];
                                       self.allPhotos=[json  valueForKeyPath:ALL_PHOTOS];
                                       
                                       NSLog(@"block中");

                                       dispatch_async(dispatch_get_main_queue(), ^
                                                      {
                                                          [self.collectionView reloadData];
                                                          
                                                      });
                                       
                                       
                                   }
                               }];
    
    NSLog(@"block之后");

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
//    NSLog(@"cellforintem:%@",self.allPhotos);
    [self DisplaySummaryPhoto:self.allPhotos atIndexPath:indexPath];
    [self getImageFromURL:self.urlOfThumbnails cells:cell];

    dispatch_async(dispatch_get_main_queue(), ^{
        cell.PhotoImageView.image=self.image;

    });
    cell.layer.borderWidth=0.3f;
    cell.layer.borderColor=[UIColor grayColor].CGColor;
    cell.layer.cornerRadius=8;

    return  cell;
        
    }



@end
