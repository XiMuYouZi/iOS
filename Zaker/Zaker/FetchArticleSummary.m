//
//  FetchArticleSummary.m
//  Zaker
//
//  Created by Mia on 15/11/18.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "FetchArticleSummary.h"
#import "FetchArticleDetail.h"
#import "FetchArticleSummaryCell.h"
#import "showWeiBo.h"
#import "ArticleSummarySliderNavigation.h"
#import "articleSummaryDB.h"


@interface FetchArticleSummary ()
//@property(nonatomic,copy)NSArray *titles;
@property(nonatomic,copy)NSArray *articles;

@property(nonatomic,copy)NSDictionary *NumnberOfArticles;
@property(nonatomic) FetchArticleDetail *articleView;
@property (nonatomic)articleSummaryDB *articleSummaryDB;




@end

@implementation FetchArticleSummary


# pragma mark - init
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self fetch];
    NSLog(@"%@",self.theMagazineURL);
    self.navigationItem.title=self.theNameOfMagazine;
    [_articleSummaryDB createDB ];

    
    
    
    
}

- (instancetype)init {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self = [sb instantiateViewControllerWithIdentifier:@"FecthAtricleSummary"];
    _articleSummaryDB=[[articleSummaryDB alloc]init];
    return self;
}




#pragma mark -点击不同cell跳转到不同view

-(void)prepareWebViewController:(FetchArticleDetail *)webview toDisplayArticle:(NSArray *)articles  atIndexPath:(NSIndexPath *)indexpath
{
    NSDictionary *article=_articleSummaryDB.allArticles[indexpath.row];
    NSURL *url=[NSURL URLWithString:article[@"url"]];
    webview.Title=article[@"title"];
    webview.URL=url;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //常规做法是从tableview的单元格连线segue到下一个页面，这样点击单元格就可以跳转了
//    下面这句话的使用场景是：不是从cell连线segue到下一个页面，而是页面本身连线segue到下一个页面，也就是两个viewcontroller之间的segue，然后在需要跳转的地方(这里是被点击的单元格)指定segue的名字，这样可以实现在一个页面内点击不同的控件跳转到不同的页面
    if (indexPath.row==0) {
        [self performSegueWithIdentifier:@"showWeiBo" sender:self];

    }
    else
    {
        [self performSegueWithIdentifier:@"show detailArticles" sender:self];
    }

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //使用了上面的didselectrowAtindexPath方法，就必须使用indexPathForSelectedRow获取点击行的indexpath，不能使用indexPathForCell:sender 获取了
    NSIndexPath *indexPath=[self.tableView  indexPathForSelectedRow];
        if (indexPath)
        {
            if ([segue.identifier isEqualToString:@"show detailArticles"])
            {
                if ([segue.destinationViewController isKindOfClass:[FetchArticleDetail class]])
                {
                    [self prepareWebViewController:segue.destinationViewController toDisplayArticle:self.articles atIndexPath:indexPath];

                }
            }
            if ([segue.identifier isEqualToString:@"showWeiBo"])
            {
                if ([segue.destinationViewController isKindOfClass:[showWeiBo class]])
                {
                    NSLog(@"!!");
                    showWeiBo *weibo=segue.destinationViewController;
                    weibo.navigationBarTitle=@"新浪微博";
                    
                }
            }
        }
    
}




#pragma mark - 获取后台数据

- (IBAction)fetch
{
    [self.refreshControl beginRefreshing];
//    [self fetchURL];
    NSLog(@"%@",_theMagazineURL);
    
    NSURL *url = [NSURL URLWithString:_theMagazineURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"fefa4eb543425fc64ab767f301d934ad" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, (long)error.code);
                               } else {
                                   
                                   NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
                                   
                                   // 把获取的字典转换为可变字典，然后去掉键值为code和msg的值，因为这两个值无用
                                   NSMutableDictionary *jsondata=[[NSMutableDictionary alloc]init];
                                   [jsondata addEntriesFromDictionary:json];
                                   
                                       [jsondata removeObjectForKey:@"code"];
                                       [jsondata removeObjectForKey:@"msg"];
                                   
                                   
                                   if ([self.theNameOfMagazine isEqualToString:@"Apple新闻"])
                                   {
                                       self.articles = [jsondata allValues][0];
                                       
//                                       把数据转换成json格式存入数据库，是为了保存数据的原格式NSArray，这样读取出来的格式也是NSArray
                                    NSData *jsonData = [NSJSONSerialization  dataWithJSONObject:self.articles options:NSJSONWritingPrettyPrinted error:nil];
                                    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                                       NSLog(@"json:%@",jsonStr);
//                                       [_articleSummaryDB inserts:jsonStr];
               

                                      
                                   }else{
                                       self.articles = [jsondata allValues];
                                       NSData *jsonData = [NSJSONSerialization  dataWithJSONObject:self.articles options:NSJSONWritingPrettyPrinted error:nil];
                                       NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

//                                       [_articleSummaryDB inserts:jsonStr];
                                       

                                        };
//                                   NSLog(@"articles:%@",self.articles);

                                   dispatch_async(dispatch_get_main_queue(), ^
                                                  {
                                                      [self.refreshControl endRefreshing];
                                                      [self.tableView reloadData];
                                                  });

                                   
                                
                                  
                                   
                               }
                           }];
}






-(NSData *) getArticleImage:(NSDictionary *)Article
{
    
    return [NSData dataWithContentsOfURL:[NSURL URLWithString:Article[@"picUrl"]]];
    
    
}





#pragma mark - tableView delegate和DataSource
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112.f;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.articles count];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (indexPath.row==0)
    {

        return  self.view.bounds.size.height*1/4;
    }
    return  112;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"Articles";
    static NSString *HeadIdentifier=@"head";
    [_articleSummaryDB query];
    NSLog(@"%@",_articleSummaryDB.allArticles[0]);
    if (indexPath.row==0) {
        FetchArticleSummaryCell *headcell=[tableView dequeueReusableCellWithIdentifier:HeadIdentifier forIndexPath:indexPath];
        return headcell;
        

    }else
    {

    FetchArticleSummaryCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
//        从数据库获取数据
    NSDictionary *article=_articleSummaryDB.allArticles[indexPath.row];
    cell.HeadLabel.text=article[@"title"];
    cell.SubHeadLabel.text=article[@"description"];
    
    //label内部文字换行显示，3行
    cell.SubHeadLabel.lineBreakMode=NSLineBreakByCharWrapping;
    cell.SubHeadLabel.numberOfLines=3;
    
    cell.FootNoteLabel.text=article[@"time"];
    if ([self getArticleImage:article]) {
        cell.articleImage.image=[UIImage imageWithData:[self getArticleImage:article]];
//        cell.articleImage.layer.cornerRadius = 40.f;
//       cell.articleImage.layer.masksToBounds = YES;
    }else
    {
        cell.articleImage.image=[UIImage imageNamed:@"头像-2.jpg"];
//        cell.articleImage.layer.cornerRadius = 40.f;
//        cell.articleImage.layer.masksToBounds = YES;

    }
    
    return cell;
    }
}


@end
