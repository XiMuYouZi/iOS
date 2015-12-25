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





-(void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchPhoto];
    self.navigationItem.title=self.thePhotosNAME;


}


//下载图片
-(void) getImageFromURL:(NSString *)fileURL {
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^
//                   {
                       NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
                       
                       self.image = [UIImage imageWithData:data];
 
                   
//                   });
    
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

//    dispatch_async(dispatch_get_main_queue(), ^{
        cell.PhotoImageView.image=self.image;

//    });
    cell.layer.borderWidth=0.3f;
    cell.layer.borderColor=[UIColor grayColor].CGColor;
    cell.layer.cornerRadius=8;

    return  cell;
        
    }



@end
