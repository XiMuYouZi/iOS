//
//  ViewController.m
//  SearchbarSimpleTable
//
//  Created by 关东升 on 2015-3-18.
//  本书网站：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  QQ：1575716557 邮箱：jylong06@163.com
//  QQ交流群：239148636/274580109
//  
//

#import "ViewController.h"

@interface ViewController ()  <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) NSArray *listTeams;
@property (nonatomic, strong) NSMutableArray *listFilterTeams;

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSUInteger)scope;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置搜索栏委托对象为当前视图控制器
    self.searchBar.delegate = self;
    
    //设定搜索栏ScopeBar隐藏
    self.searchBar.showsScopeBar = NO;
    [self.searchBar sizeToFit];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"team"
                                           ofType:@"plist"];
    //获取属性列表文件中的全部数据
    self.listTeams = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    //初次进入查询所有数据
    [self filterContentForSearchText:@"" scope:-1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Content Filtering
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSUInteger)scope;
{
    
    if([searchText length]==0)
    {
        //查询所有
        self.listFilterTeams = [NSMutableArray arrayWithArray:self.listTeams];
        return;
    }
    
    NSPredicate *scopePredicate;
    NSArray *tempArray ;
    
    switch (scope) {
        case 0: //英文 image字段保存英文名
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.image contains[c] %@",searchText];
            tempArray =[self.listTeams filteredArrayUsingPredicate:scopePredicate];
            self.listFilterTeams = [NSMutableArray arrayWithArray:tempArray];
            
            break;
        case 1: //中文 name字段是中文名
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
            tempArray =[self.listTeams filteredArrayUsingPredicate:scopePredicate];
            self.listFilterTeams = [NSMutableArray arrayWithArray:tempArray];
            break;
        default:
            //查询所有
            self.listFilterTeams = [NSMutableArray arrayWithArray:self.listTeams];
            break;
    }
}

#pragma mark --UITableViewDataSource 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listFilterTeams count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowDict = [self.listFilterTeams objectAtIndex:row];
    cell.textLabel.text =  [rowDict objectForKey:@"name"];
    cell.detailTextLabel.text = [rowDict objectForKey:@"image"];
    
    NSString *imagePath = [rowDict objectForKey:@"image"];
    imagePath = [imagePath stringByAppendingString:@".png"];
    cell.imageView.image = [UIImage imageNamed:imagePath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark --UISearchBarDelegate 协议方法
//  获得焦点，成为第一响应者
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsScopeBar = TRUE;
    [self.searchBar sizeToFit];
    return YES;
}
//点击键盘上的搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchBar.showsScopeBar = NO;
    [self.searchBar sizeToFit];
    [self.searchBar resignFirstResponder];
}
//点击搜索栏取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //查询所有
    self.searchBar.text=@"";
    [self filterContentForSearchText:self.searchBar.text scope:-1];
    self.searchBar.showsScopeBar = NO;
    [self.searchBar sizeToFit];
    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
}

//当文本内容发生改变时候调用
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentForSearchText:self.searchBar.text scope:self.searchBar.selectedScopeButtonIndex];
    [self.tableView reloadData];
}

//当搜索范围选择发生变化时候调用
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self filterContentForSearchText:self.searchBar.text scope:selectedScope];
    [self.tableView reloadData];
}

@end
