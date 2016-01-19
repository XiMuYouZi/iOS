//
//  ViewController.m
//  CustomCell
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
#import "CustomCell.h"

@interface ViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) NSArray *listTeams;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(nonatomic,strong)NSMutableArray *listFilterTeams;
@property(nonatomic,strong)NSDictionary *dicData;
@property(nonatomic,strong)NSArray *listGroupName;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
	NSString *plistPath = [bundle pathForResource:@"team_dictionary"
                                           ofType:@"plist"];
    //获取属性列表文件中的全部数据
	self.dicData= [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *templist=[self.dicData allKeys];
    self.listGroupName=[templist sortedArrayUsingSelector:@selector(compare:)];
    
    }



#pragma mark --UITableViewDataSource 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *groupName=[self.listGroupName objectAtIndex:section];
    NSArray *listTeams=[self.dicData objectForKey:groupName];
    return [listTeams count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    NSArray *listTeams=[self.dicData objectForKey:[self.listGroupName objectAtIndex:indexPath.section]] ;
    cell.myLabel.text=[listTeams objectAtIndex:indexPath.row];
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.listGroupName count];
}




-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle=[self.listGroupName objectAtIndex:section];
    UILabel *label = [[UILabel alloc] init] ;
    label.frame = CGRectMake(0, 0, tableView.bounds.size.width, 22);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size    :18];
    label.text = sectionTitle;
    label.textAlignment=NSTextAlignmentCenter;
    
    // Create header view and add label as a subview
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)];
    [sectionView setBackgroundColor:[UIColor lightGrayColor]];
//    [sectionView addSubview:label];
    return sectionView;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *listTitles=[[NSMutableArray alloc]initWithCapacity:[self.listGroupName count]];
    for (NSString *item in self.listGroupName) {
        NSString *title=[item substringToIndex:1];
        [listTitles addObject:title];
    }
    return listTitles;
}
@end
