//
//  showPhotoWithCollectionView.m
//  Zaker
//
//  Created by Mia on 15/12/2.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "showPhotoWithCollectionView.h"
#import "RAMCollectionViewFlemishBondLayout.h"
#import "FetchPhotoSummary.h"
#import "FetchPhotoCell.h"
#import "showPhotoWithModalView.h"


@interface showPhotoWithCollectionView ()
@property(nonatomic,strong)NSMutableArray *URLOfPhoto;
@property(nonatomic,strong)NSArray *allOfThePhoto;
@property(nonatomic)NSString *titlesOfPhoto;
@property(nonatomic)FetchPhotoSummary *photoSummary;
@property (nonatomic, strong)RAMCollectionViewFlemishBondLayout *collectionViewLayout;
@property (nonatomic,strong )UIImage *image;
@property(nonatomic,strong)NSMutableArray *allImage;
@property (nonatomic, readonly) UICollectionView *collectionView;
@property(nonatomic)showPhotoWithModalView *SPWMVS;



@end




@implementation showPhotoWithCollectionView
static NSString *const CellIdentifier = @"MyCell";

#define ALL_PHOTOS_URL @"list"
#define ALL_PHOTOS_TITLE @"title"
#define BIG_PHOTO @"big"
#define MEDIUM_PHOTO @"middle"


#pragma mark - 传值给showPhotoWithModal类的代理

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    showPhotoWithModalView *SPWMV=[[showPhotoWithModalView alloc]init];
//    self.delegates=_SPWMVs;
//
//    if ([self.delegates respondsToSelector:@selector(getAllPhotos:atIndexPath:)])
//    {
//        NSLog(@"!!!");
//    [_delegates getURLofPhoto:self.URLOfPhoto atIndexPath:indexPath ];
//    [self presentViewController:SPWMV animated:YES completion:nil];
//    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
//    }
#warning 一定要设置下面这句话，不然无法传值，这句话是把自己的showphotowithmodal属性和showphotowithmodal类对应起来
    self.SPWMVS=SPWMV;
    
    _SPWMVS.image=_allImage[indexPath.row];
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:SPWMV];
    navController.modalPresentationStyle=UIModalPresentationPopover;
    [self presentViewController:navController animated:YES completion:nil];
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


//此处设置代理无效
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:  animated];
//    _photoSummary.delegate=self;
//}

#pragma mark - 实现FetchPhotoSummary类的代理方法
-(void)getAllPhotos:(NSArray *)allPhotos atIndexPath:(NSIndexPath *)indexPath
{
    _URLOfPhoto=[[allPhotos valueForKeyPath:ALL_PHOTOS_URL][indexPath.row] valueForKeyPath:MEDIUM_PHOTO];
    _titlesOfPhoto=[allPhotos valueForKeyPath:ALL_PHOTOS_TITLE][indexPath.row];
    _allOfThePhoto=allPhotos;
//    NSLog(@"urlofphoto:%@",_URLOfPhoto);
}



#pragma mark - 初始化方法
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        [self setup];
//    }
//    
//    return self;
//}

-(void)viewDidLoad
{
    [self fetchAllImage];
    NSLog(@"viewdidload");
    
    self.collectionViewLayout = [[RAMCollectionViewFlemishBondLayout alloc] init];
    self.collectionViewLayout.delegate = self;
    self.collectionViewLayout.numberOfElements = 3;
    self.collectionViewLayout.highlightedCellHeight = (self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height)/2;
    self.collectionViewLayout.highlightedCellWidth = self.view.bounds.size.width/3*2;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[FetchPhotoCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    self.view = collectionView;


}

#pragma mark - Custom Getter
//- (UICollectionView *)collectionView
//{
//    return (UICollectionView *)self.view;
//}

#pragma mark - Setup
- (void)setup
{
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.allImage count];
}




#pragma mark -  获取和设置照片

-(UIImage *) getPhoto:(NSString *)fileURL {
    
#warning 主队列被阻塞，需要等到所有图片都下载完毕，才能进行其他操作
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    self.image = [UIImage imageWithData:data];
    return [UIImage imageWithData:data];
    
}


-(void)fetchAllImage
{
 
    
    
    self.allImage   =[[NSMutableArray alloc]init];

    
    for (NSInteger i=0;i<[self.URLOfPhoto count];i++) {
        NSString *url=self.URLOfPhoto[i];
        [self.allImage addObject:[self getPhoto:url]];
//        NSLog(@"%@",self.allImage );
        
    }
    
}





#pragma mark -  collectionView的delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FetchPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UIImage *cellImage=_allImage[indexPath.row];
    cell.PhotoImageView.image=cellImage;
//    NSLog(@"%ld",(long)indexPath.row);

    
    return cell;
}



//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;
//{
//    UICollectionReusableView *titleView;
//    
//    if (kind == RAMCollectionViewFlemishBondHeaderKind) {
//        titleView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeaderIdentifier forIndexPath:indexPath];
//        ((RAMCollectionAuxView *)titleView).label.text = @"Header";
//    } else if (kind == RAMCollectionViewFlemishBondFooterKind) {
//        titleView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FooterIdentifier forIndexPath:indexPath];
//        ((RAMCollectionAuxView *)titleView).label.text = @"Footer";
//    }
//    
//    return titleView;
//}



#pragma mark - RAMCollectionViewVunityLayoutDelegate
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(RAMCollectionViewFlemishBondLayout *)collectionViewLayout estimatedSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), 100);
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(RAMCollectionViewFlemishBondLayout *)collectionViewLayout estimatedSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), 100);
//}



- (RAMCollectionViewFlemishBondLayoutGroupDirection)collectionView:(UICollectionView *)collectionView layout:(RAMCollectionViewFlemishBondLayout *)collectionViewLayout highlightedCellDirectionForGroup:(NSInteger)group atIndexPath:(NSIndexPath *)indexPath
{
    RAMCollectionViewFlemishBondLayoutGroupDirection direction;
    
    if (indexPath.row % 2) {
        direction = RAMCollectionViewFlemishBondLayoutGroupDirectionRight;
    } else {
        direction = RAMCollectionViewFlemishBondLayoutGroupDirectionLeft;
    }
    
    return direction;
}



@end
