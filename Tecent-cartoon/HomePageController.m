//
//  HomePageController.m
//  Tecent-cartoon
//
//  Created by Mia on 16/1/16.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "HomePageController.h"
#import "BannerView.h"
#import "bannerCellModel+FetchPhoto.h"
#import "UITableView+FDTemplateLayoutCell.h"


@interface HomePageController ()
@property (nonatomic,strong)BannerView *bannerView;
@property(nonatomic,strong)NSArray *cellModel;

@end

@implementation HomePageController

static NSString *reuseIdentifier=@"BannerView";

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    隐藏navigationBar
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:NO];
    [self updateViewConstraints];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[BannerView class] forCellReuseIdentifier:NSStringFromClass([BannerView class])];

    [self.view addSubview:self.tableView];
    
    
//防止Block循环
    __weak HomePageController *weakSelf = (HomePageController *)self;
  
    
//    从model 获取数据，{}内的代码就是实现在bannerCellModel+FetchPhoto.h定义的block
//    如果使用self.cellModel=cellcontent,那么就会导致block循环引用。
//    因为bock 对{}内部的捕获变量拥有强引用，也就是对self.cellModel有强引用。
//    如果再使用self.cellModel=cellcontent,那么self.cellModel对block变量cellcontent也强引用，导致引用循环
    [bannerCellModel fetchBannerPhotos:^(NSArray *cellContent) {
        weakSelf.cellModel=cellContent;
        [weakSelf.tableView reloadData];
    }];
    
    
    NSLog(@"viewdidload:%@",_cellModel);
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"row:%@",_cellModel);

    return _cellModel.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"section:%@",_cellModel);

    return 1;
}

//设置section Header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle=@"12121";
    UILabel *label = [[UILabel alloc] init] ;
    label.frame = CGRectMake(0, 0, tableView.bounds.size.width, 22);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:156.f/255.f green:156.f/255.f blue:154.f/255.f alpha:1];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size    :18];
    label.text = sectionTitle;
    label.textAlignment=NSTextAlignmentCenter;

    // Create header view and add label as a subview
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)];
    sectionView.backgroundColor= [UIColor colorWithRed:242.f/255.f green:242.f/255.f blue:235.f/255.f alpha:1];
        [sectionView addSubview:label];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection :(NSInteger)section{
    return 22;
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    NSLog(@"cell:%@",_cellModel);


    BannerView *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell=[[BannerView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
        [cell configCell:_cellModel[indexPath.row]];
    
    return cell;
}

//cell 的高度自动计算
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:reuseIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [cell configCell:_cellModel[indexPath.row]];
    }];
}

@end
