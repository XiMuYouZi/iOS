//
//  Allarticles.m
//  Zaker
//
//  Created by Mia on 15/11/19.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "Allarticles.h"
#import "CollectionCell.h"
#import "FetchArticleSummary.h"
#import "FetchPhotoDetail.h"
#import "FetchPhotoCell.h"
#import "FetchPhotoSummary.h"


@interface Allarticles ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,copy)NSArray *articles;
@property(nonatomic,copy)NSArray *allOFmagazineURL;
@property(nonatomic,copy)NSString *articleURL;
@property(nonatomic)FetchArticleSummary *ArticleSummaryTableView;
@property(nonatomic)FetchPhotoDetail *PhotoDetailCollectionView;
@property(nonatomic)UIView *backgroundView;
@property(nonatomic)UIView *selectedBackgroundView;
@property (nonatomic)UIViewController *viewcontrollers;




@end

@implementation Allarticles
static NSString * const reuseIdentifierOfMagazine = @"the name of magazine";




-(NSArray *)allMagazineURL
{
    
                         return  @[[NSString stringWithFormat: @"http://apis.baidu.com/showapi_open_bus/pic/pic_search?type=4002&page=%d",arc4random()%20],
                                  [NSString stringWithFormat:@"http://apis.baidu.com/txapi/tiyu/tiyu?num=20&page=%d",arc4random()%10],
                                  [NSString stringWithFormat:@"http://apis.baidu.com/txapi/keji/keji?num=20&page=%d",arc4random()%10],
                                  [NSString stringWithFormat:@"http://apis.baidu.com/txapi/social/social?num=20&page=%d",arc4random()%10],
                                  [NSString stringWithFormat:@"http://apis.baidu.com/txapi/health/health?num=20&page=%d",arc4random()%10],
                                  [NSString stringWithFormat:@"http://apis.baidu.com/txapi/qiwen/qiwen?num=20&page=%d",arc4random()%10],
                                  [NSString stringWithFormat:@"http://apis.baidu.com/txapi/huabian/newtop?num=20&page=%d",arc4random()%10],
                                  [NSString stringWithFormat:@"http://apis.baidu.com/txapi/apple/apple?num=20&page=%d",arc4random()%10]];
    

}


-(void)prepareTableViewController:(FetchArticleSummary *)tableView atIndexPath:(NSIndexPath *)indexPath
{

    tableView.theMagazineURL=[self allMagazineURL][indexPath.row];
    tableView.theNameOfMagazine=[self getTheNameOfMagazine:indexPath];
    
}

-(void)preparePhotoDetailViewController:(FetchPhotoSummary*)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    collectionView.thePhotosURL=[self allMagazineURL][indexPath.row];
    collectionView.thePhotosNAME=[self getTheNameOfMagazine:indexPath];
}




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        [self performSegueWithIdentifier:@"show photos" sender:self];

    }else
    {
        [self performSegueWithIdentifier:@"show articles" sender:self];
    }
    
}


//如果是从cell连线segue到另外一个视图，这是sender就是点击的cell，我这里是两个视图之间的连接
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([sender isKindOfClass:[CollectionCell class]])
//    {
    //我好机智，啊哈哈，竟然想到了indexPathForSelectedItems这个方法
        NSIndexPath *indexPath=[self.collectionView indexPathsForSelectedItems][0];
            if ([segue.identifier isEqualToString:@"show photos"])
            {
                if ([segue.destinationViewController isKindOfClass:[FetchPhotoSummary class]])
                {
                    
                    [self preparePhotoDetailViewController:segue.destinationViewController atIndexPath:indexPath];
                    
                }
            
        }
        

            if ([segue.identifier isEqualToString:@"show articles"])
            {
                if ([segue.destinationViewController isKindOfClass:[FetchArticleSummary class]])
                {
                    
                    [self prepareTableViewController:segue.destinationViewController atIndexPath:indexPath];
                    
                }
            }
                    
        
//    }
}






-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}




-(NSArray *)allOfTheMagazineName
{
    return @[@"美女图片",@"体育新闻",@"科技新闻",@"社会新闻",@"生活新闻",@"奇闻异事",@"娱乐新闻",@"Apple新闻"];
}

-(NSString *)getTheNameOfMagazine:(NSIndexPath *)indexpath
{
    return [self allOfTheMagazineName][indexpath.row];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
       CollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierOfMagazine forIndexPath:indexPath];
        cell.CellLabel.text=[NSString stringWithFormat:@"%@",[self getTheNameOfMagazine:indexPath]];
//        NSLog(@"%@",[self getTheNameOfMagazine:indexPath]);
//        NSString *imageToLoad = [NSString stringWithFormat:@"%ld.png", (long)indexPath.row];
//        cell.Cellimage.image=[UIImage imageNamed:imageToLoad];
//        NSLog(@"%@",cell.CellLabel.text);

        cell.layer.borderWidth=0.3f;
        cell.layer.borderColor=[UIColor grayColor].CGColor;
        return  cell;

//    }
    

    
}


@end
