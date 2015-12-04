//
//  showWeiBo.m
//  Zaker
//
//  Created by Mia on 15/12/4.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "showWeiBo.h"
#import "weiboCell.h"

@interface showWeiBo()
@property(nonatomic,copy)NSArray *allWeiBo;
@end


@implementation showWeiBo
#define alldata @"data.books"



-(void)viewDidLoad{
    [super viewDidLoad];
    [self fetchWeibo:self.refreshControl];
    

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
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else
                               {
                                   
                                   NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
                                   NSArray *allWeiBo=[json valueForKeyPath:alldata];
                                   _allWeiBo=allWeiBo;
                                                                      NSLog(@"%@",_allWeiBo);
                                   //                                   NSLog(@"%lu",(unsigned long)[self.allWeiBo count]);
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
    return 112.f;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return  [self.allWeiBo count];
}




//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    if (indexPath.row==0)
//    {
//        
//        return  self.view.bounds.size.height*1/4;
//    }
//    return  112;
//}


-(UIImage *)getImage:(NSArray *)allWeiBo atIndexPath:(NSIndexPath *)indexPath  imageName:(NSString *)name
{
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:allWeiBo[indexPath.row][name]]];

    return [UIImage imageWithData:data];
    

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *CellIdentifier=@"weibo";
    
    
        weiboCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        NSDictionary *Weibo=self.allWeiBo[indexPath.row];
    
        cell.UserName.text=Weibo[@"userName"];
        cell.time.text=Weibo[@"startTime"];

        cell.Content.text=Weibo[@"text"];
        cell.Content.lineBreakMode=NSLineBreakByCharWrapping;
        cell.Content.numberOfLines=3;
    
        cell.userImage.image=[self getImage:_allWeiBo atIndexPath:indexPath imageName:@"userHeadImg"];
        cell.userImage.layer.cornerRadius = 29.f;
        cell.userImage.layer.masksToBounds = YES;
    
        cell.titleImage.image=[self getImage:_allWeiBo atIndexPath:indexPath imageName:@"headImage"];
            
        
        return cell;
}







                               
@end


