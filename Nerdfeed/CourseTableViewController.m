//
//  CourseTableViewController.m
//  Nerdfeed
//
//  Created by Mia on 15/10/26.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "CourseTableViewController.h"
#import "WebViewController.h"

@class WebViewController;

@interface CourseTableViewController ()
@property(nonatomic)NSURLSession *session;
@property(nonatomic,copy)NSArray *courses;
@property(nonatomic,copy)NSString *titles;

@end

@implementation CourseTableViewController


//点击tableview的相应课程名，就使用webviewcontroller打开课程详细信息的网页
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *course=self.courses[indexPath.row];
    NSURL *URL=[NSURL URLWithString:course[@"url"]];
    NSLog(@"%@",URL);
//    WebViewController页面的抬头
    self.webViewController.title=course[@"title"];
//    WebViewController页面的请求url，没有这个打不开网页
    self.webViewController.URL=URL;
    
//    使用viewcontroller对象的splitviewcontroller消息可以得到一个指针，指向该对象所属的splitviewcontroller对象
//    如果viewcontroller对象不属于任何UISplitViewController对象，就返回nil。下面这句话的意思就是村存在splitviewcontroller
//    就说明设备不是ipad，就把UIWebViewcontroller推入UINavigationController来显示，如果是ipad，就由UISplitViewController
//    来显示
    if (!self.splitViewController) {
        [self.navigationController pushViewController:self.webViewController animated:YES];

    }
}




//从http://bookapi.bignerdranch.com/courses.json获取json数据并在控制台输出
- (void)fetchFeed
{
    NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask =
    [self.session dataTaskWithRequest:req
                    completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error) {
         
         NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:0
                                                                      error:nil];
         self.courses = jsonObject[@"courses"];
//         NSLog(@"%@", self.courses);
//         请求web服务之后，需要重新加载tableviewcontroller的数据才可以显示课程名称
//         这个操作默认是在后台执行，而修改用户界面的代码必须在主线程中运行，所以要使用下面的代码把reloadata
//         放到主线程中执行
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
         
     }];
    [dataTask resume];
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.courses count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                    forIndexPath:indexPath];
    
    NSDictionary *course = self.courses[indexPath.row];
    cell.textLabel.text = course[@"title"];
    
    return cell;
}



//在UITableViewCell初始化的时候获取json数据
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self=[super initWithStyle:style];
    if (self) {
        self.navigationController.title=@"BNR Courses";
        NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
        _session=[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
//        获取json数据
        [self fetchFeed];
        
    }
    return self;
}



-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}



@end
