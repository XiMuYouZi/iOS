//
//  showWeiBo.m
//  Zaker
//
//  Created by Mia on 15/12/4.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "showWeiBo.h"
#import "weiboCell.h"
#import "UITableView+FDTemplateLayoutCell.h"


@interface showWeiBo()
@property(nonatomic,copy)NSArray *allWeiBo;
//@property(nonatomic,copy)NSMutableArray *allWeiboWithSection;
@property(nonatomic,strong)NSString *cellHeight;
@property(nonatomic,copy)NSMutableDictionary *allWeiBoAddHeight;
@property (nonatomic, strong) UITableViewCell *prototypeCell;

@end


@implementation showWeiBo
#define alldata @"data.books"


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
        [self.tableView reloadData];
    NSLog(@"will");

    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"did");

    [self fetchWeibo:self.refreshControl];
    self.tableView.estimatedRowHeight=300.0;
    self.tableView.rowHeight =UITableViewAutomaticDimension;
    




    
//    self.tableView.fd_debugLogEnabled = YES;
    
    // Cache by index path initial
    
    

    
    //ios 8特有的自动计算cell的高度



    
}



-(NSMutableDictionary *)allWeiBoAddHeight
{
    for (NSMutableDictionary *dic in _allWeiBo) {
        [dic setObject:_cellHeight forKey:@"cellHeight"];
        _allWeiBoAddHeight=dic;
        
    }
    return _allWeiBoAddHeight;
    
}




- (IBAction)fetchWeibo:(UIRefreshControl *)sender {
    [self.refreshControl beginRefreshing];
    NSString *httpUrl =  @"http://apis.baidu.com/qunartravel/travellist/travellist";
    NSString *chineseUrl=@"泸沽湖";
    NSString *finalStr=[chineseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    NSString *httpArg = [NSString stringWithFormat:@"query=%@&page=%d",finalStr,arc4random()%20+1] ;
    
    NSString *Url=[NSString stringWithFormat: @"%@?%@",httpUrl,httpArg];
    NSLog(@"%@",Url);
    NSURL *url = [NSURL URLWithString: Url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"fefa4eb543425fc64ab767f301d934ad" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, (long)error.code);
                               } else
                               {
                                   
                                   NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
                                   NSArray *allWeiBo=[json valueForKeyPath:alldata];
                                   _allWeiBo=allWeiBo;
                                   
//                                                                      NSLog(@"%@",_allWeiBo);
                                   //                                   NSLog(@"%lu",(unsigned long)[self.allWeiBo count]);
                                   
//                                   id array1=[NSMutableArray array];
//                                   NSMutableArray *allWeiboWithSection=[NSMutableArray array];
//                                   
//                                   for (NSInteger i=0;i<_allWeiBo.count;i++)
//                                   {
//                                       
//                                       NSLog(@"%lu----------------------------------%ld",(unsigned long)_allWeiBo.count,(long)i);
//                                       [array1 addObject:_allWeiBo[i]];
//                                       NSLog(@"arrary1:%@",array1);
//                                       
//                                       [allWeiboWithSection addObject:array1];
//                                       NSLog(@"allweibo:%@",allWeiboWithSection);
//                                       
//                                       
//                                       [array1 removeAllObjects];
//                                       NSLog(@"arrary11:%@",array1);
//                                       
//                                       
//                                   }
//                                   NSLog(@"allweibo:%@",allWeiboWithSection);

                                   
                                   dispatch_async(dispatch_get_main_queue(), ^
                                                  {
                                                      [self.refreshControl endRefreshing];
                                                      [self.tableView reloadData];
                                                      
                                                  });
                                   
                                   
                               }
                           }];

}







#pragma mark - tableView delegate和DataSource
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300.f;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static weiboCell *templateCell;
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        templateCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([weiboCell class])];
//    });
//    
//    // 获取对应的数据
//    Case4DataEntity *dataEntity = _data[(NSUInteger) indexPath.row];
//    
//    // 填充数据
//    [templateCell setupData:dataEntity];
//    
//    // 判断高度是否已经计算过
//    if (dataEntity.cellHeight <= 0) {
//        // 根据当前数据，计算Cell的高度，注意+1
//        dataEntity.cellHeight = [templateCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
//    }
//    
//    return dataEntity.cellHeight;
//}




//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//            return [tableView fd_heightForCellWithIdentifier:@"weibo" cacheByIndexPath:indexPath configuration:^(weiboCell *cell) {
//        NSDictionary *Weibo=self.allWeiBo[indexPath.row];
//        
//        cell.UserName.text=Weibo[@"userName"];
//        cell.time.text=Weibo[@"startTime"];
//        
//        cell.Content.text=Weibo[@"text"];
//        cell.Content.lineBreakMode=NSLineBreakByCharWrapping;
//        cell.Content.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
//        cell.Content.numberOfLines=0;
//        //    [cell sizeToFit];
//        
//        cell.userImage.image=[self getImage:_allWeiBo atIndexPath:indexPath imageName:@"userHeadImg"];
//        cell.userImage.layer.cornerRadius = 29.f;
//        cell.userImage.layer.masksToBounds = YES;
//        
//        cell.titleImage.image=[self getImage:_allWeiBo atIndexPath:indexPath imageName:@"headImage"];
//    }];
//}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return  1;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_allWeiBo count];
}

//下面两个方法设置其中一个就可以设置section之间的高度了了
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 100.0;
//}

//设置section之间的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.f;
}


-(UIImage *)getImage:(NSArray *)allWeiBo atIndexPath:(NSIndexPath *)indexPath  imageName:(NSString *)name
{
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:allWeiBo[indexPath.section][name]]];

    return [UIImage imageWithData:data];
    

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier=@"weibo";
    
    weiboCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *Weibo=_allWeiBo[indexPath.section];
    
    cell.UserName.text=Weibo[@"userName"];
    cell.time.text=Weibo[@"startTime"];
    
    cell.Content.text=Weibo[@"text"];
    cell.Content.lineBreakMode=NSLineBreakByCharWrapping;
//    cell.Content.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 80;

    cell.Content.numberOfLines=0;
    
    cell.userImage.image=[self getImage:_allWeiBo atIndexPath:indexPath imageName:@"userHeadImg"];
//    cell.userImage.layer.cornerRadius = 34.f;
//    cell.userImage.layer.masksToBounds = YES;
    
    cell.titleImage.image=[self getImage:_allWeiBo atIndexPath:indexPath imageName:@"headImage"];
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];

        return cell;
}







                               
@end


