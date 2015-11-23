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
#import "ViewController.h"


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
    
    return @[@"http://apis.baidu.com/txapi/mvtp/meinv?num=20",
                                  @"http://apis.baidu.com/txapi/tiyu/tiyu?num=10&page=3",
                                  @"http://apis.baidu.com/txapi/keji/keji?num=10&page=1",
                                  @"http://apis.baidu.com/txapi/social/social?num=10&page=1",
                                  @"http://apis.baidu.com/txapi/health/health?num=10&page=1",
                                  @"http://apis.baidu.com/txapi/qiwen/qiwen?num=10",
                                  @"http://apis.baidu.com/txapi/huabian/newtop?num=10&page=1",
                                  @"http://apis.baidu.com/txapi/apple/apple?num=10&page=1"];
    
    

}
//-(void)viewDidLoad
//{
//    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:reuseIdentifierOfMagazine];
//    self.ArticleSummaryTableView=[[FetchArticleSummary alloc]init];
//    self.PhotoDetailCollectionView=[[FetchPhotoDetail alloc]init];
//    
//    self.collectionView.delegate=self;
//    self.collectionView.dataSource=self;
//}

-(void)prepareWTableViewController:(FetchArticleSummary *)tableView atIndexPath:(NSIndexPath *)indexPath
{

    tableView.theMagazineURL=[self allMagazineURL][indexPath.row];
    tableView.theNameOfMagazine=[self getTheNameOfMagazine:indexPath];
    


}


//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
////    [self.navigationController pushViewController:self.PhotoDetailCollectionView animated:YES];
//    [self prepareWTableViewController:self.ArticleSummaryTableView atIndexPath:indexPath];
//
//
//}
//
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}





-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[CollectionCell class]])
    {
        NSIndexPath *indexPath=[self.collectionView indexPathForCell:sender];
        if (indexPath)
        {
            if ([segue.identifier isEqualToString:@"show articles"])
            {
                if ([segue.destinationViewController isKindOfClass:[FetchArticleSummary class]])
                {
                    
                    [self prepareWTableViewController:segue.destinationViewController atIndexPath:indexPath];
                    NSLog(@"%@", self.ArticleSummaryTableView.theMagazineURL);
                    
                }
            }
            
        }
        
    }
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
    if (indexPath.row==0) {
        CollectionCell *photoCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"the name of photo" forIndexPath:indexPath];
       photoCell.CellLabel.text=[NSString stringWithFormat:@"%@",[self getTheNameOfMagazine:indexPath]];
       photoCell.layer.borderWidth=0.3f;
        photoCell.layer.borderColor=[UIColor grayColor].CGColor;
        return  photoCell;

    }else
    {    CollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierOfMagazine forIndexPath:indexPath];
        cell.CellLabel.text=[NSString stringWithFormat:@"%@",[self getTheNameOfMagazine:indexPath]];
//        NSLog(@"%@",[self getTheNameOfMagazine:indexPath]);
//        NSString *imageToLoad = [NSString stringWithFormat:@"%ld.png", (long)indexPath.row];
//        cell.Cellimage.image=[UIImage imageNamed:imageToLoad];
        NSLog(@"%@",cell.CellLabel.text);

        cell.layer.borderWidth=0.3f;
        cell.layer.borderColor=[UIColor grayColor].CGColor;
        return  cell;

    }
    

    
}


@end
