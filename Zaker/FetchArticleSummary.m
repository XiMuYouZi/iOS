//
//  FetchArticleSummary.m
//  Zaker
//
//  Created by Mia on 15/11/18.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "FetchArticleSummary.h"
#import "FetchArticleDetail.h"

@interface FetchArticleSummary ()
//@property(nonatomic,copy)NSArray *titles;
@property(nonatomic,copy)NSArray *articles;

@property(nonatomic,copy)NSDictionary *NumnberOfArticles;
@property(nonatomic) FetchArticleDetail *articleView;


@end

@implementation FetchArticleSummary

-(void)prepareWebViewController:(FetchArticleDetail *)webview toDisplayArticle:(NSArray *)articles  atIndexPath:(NSIndexPath *)indexpath
{
    NSDictionary *article=articles[indexpath.row];
    NSURL *url=[NSURL URLWithString:article[@"url"]];
    webview.Title=article[@"title"];
    webview.URL=url;
//    self.articleURL=webview.URL;
//    self.articleTitle=webview.Title;
//    NSLog(@"%@",self.articleTitle);
   
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
        NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
        if (indexPath)
        {
            if ([segue.identifier isEqualToString:@"show articles"])
            {
                if ([segue.destinationViewController isKindOfClass:[FetchArticleDetail class]])
                {
                    [self prepareWebViewController:segue.destinationViewController toDisplayArticle:self.articles atIndexPath:indexPath];
                    
//                    NSLog(@"%@",self.articleTitle);


                    
                    
                }
            }
            
        }
        
    }
}




- (IBAction)fetch
{
    [self.refreshControl beginRefreshing];
    NSURL *url = [NSURL URLWithString: self.theMagazineURL];
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
                                   
                                   // 把获取的字典转换为可变字典，然后去掉键值为code和msg的值，因为这两个值无用
                                   NSMutableDictionary *jsondata=[[NSMutableDictionary alloc]init];
                                   [jsondata addEntriesFromDictionary:json];
                                   
                                       [jsondata removeObjectForKey:@"code"];
                                       [jsondata removeObjectForKey:@"msg"];
                                   
                                   if ([self.theNameOfMagazine isEqualToString:@"Apple新闻"])
                                   {
                                       self.articles = [jsondata allValues][0];

                                      
                                   }else{
                                       self.articles = [jsondata allValues];

                                        };
                                   NSLog(@"%@",self.articles);

                                   dispatch_async(dispatch_get_main_queue(), ^
                                                  {
                                                      [self.refreshControl endRefreshing];
                                                      [self.tableView reloadData];
                                                  });

                                   
                                
                                  
                                   
                               }
                           }];
}




-(void)viewDidLoad
{
    [super viewDidLoad];
    [self fetch];
    self.navigationItem.title=self.theNameOfMagazine;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Articles"];


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.articles count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"Articles";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *article=self.articles[indexPath.row];
    NSString *sourceDate=[NSString stringWithFormat:@"%@(%@)",article[@"ctime"],article[@"description"]];
    cell.textLabel.text=article[@"title"];
    cell.detailTextLabel.text=sourceDate;
    
    
    return cell;
}


@end
