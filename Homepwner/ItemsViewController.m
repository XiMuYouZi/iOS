//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Mia on 15/10/15.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItem.h"
#import "ItemStore.h"
#import "DetailViewController.h"

@interface ItemsViewController ()
//headView指向NIB的顶层对象，指向顶层对象的插座变量必须为strong
//@property (nonatomic,strong)IBOutlet UIView *headView;

@end


@implementation ItemsViewController



//修改detaiviewcontroller的数据之后需要重新更新tebleview的数据才可以看见
//更改后的表格行
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

//当用户点击tableview对象中的某个表格行，该对象会向其委托对象itemsviewcontroller
//发送tableview：didselectatindexpath：消息，那么如果需要再detailviewcontroller显示之前做一些动作，就可以在该方法中来实现
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailViewController=[[DetailViewController alloc]init];
    
    //在detailviewcontroller对象收到viewwillapper：消息之前将该对象的item属相设置为响应的BNRitem对象
    NSArray *items=[[ItemStore shareStore]allItems];
    BNRItem *selectItem=items[indexPath.row];
    detailViewController.item=selectItem;
    
    
    //在该方法中实现当用户点击某行的时候，就创建detailviewcontroller对象并压入navigationcontroller对象栈
    [self.navigationController pushViewController:detailViewController animated:YES];
}



//实现tableview的移动行的功能
- (void)tableView:(UITableView *)tableView
  moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
         toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[ItemStore shareStore] moveItemAtIndex:sourceIndexPath.row
                                        toIndex:destinationIndexPath.row];
}



//实现edit按钮下面的删除功能
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSArray *items=[[ItemStore shareStore]allItems];
        BNRItem *item=items[indexPath.row];
        [[ItemStore shareStore]removeItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}

//实现New按钮的功能，可以添加条目
-(IBAction)addNewItem:(id)sender
{
    BNRItem *newItem=[[ItemStore shareStore]createItem];
    NSInteger lastRow=[[[ItemStore shareStore]allItems]indexOfObject:newItem];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:lastRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}






//self的init方法调用的是父类的initwithstyle
-(instancetype)init
{
    self=[super initWithStyle:UITableViewStylePlain];
    //设置首页的navigationbar的title属性
    if (self) {
        UINavigationItem *navItem=self.navigationItem;
        navItem.title=@"HomePwner";
        //navItem.titleView=[[UISlider alloc]init];
        
        //在navigatbar的右边添加一个加号按钮，点击就增加新的一行
        UIBarButtonItem *bbi=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        navItem.rightBarButtonItem=bbi;
        
        //在navigatbar的右边添加一个编辑按钮
        navItem.leftBarButtonItem=self.editButtonItem;

    }
    return  self;
}



//父类的initwithstyle调用的是self的init方法，这样就可以保证无论是使用self还是父类的init方法
//都是使用UITableViewStylePlain风格
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}





//返回tableview需要现实的行数，行数等于itemstore中的item的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //itemstore sharestore是获取itemstore对象的内存地址，allitem是返回所有的item对象，
    //count是计算返回所有item对象的个数
    return [[[ItemStore shareStore]allItems]count];
}



//让tableview的第n行显示allitem数组中的第n个BNRitem对象
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建tableviewcell对象，每行表格使用默认风格,无法重tableviewcell
    //UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    //构建可以重用tableviewcell
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    //获取allItems的第n个BNRItem对象，让后讲BNRitem对象的description赋给tableviewcell对象的textlabel
    //这里的n就是该tableviewcell对象的对应的表格的行索引
    NSArray *items=[[ItemStore shareStore]allItems];
    BNRItem *item=items[indexPath.row];
    cell.textLabel.text=[item description];
    return cell;
    
}




//覆盖viewdidload方法，让系统来自动重建tableviewcell对象，viewdidload是当通过NIB或者代码方式加载view到内存之后，需要重新调整view的时候调用
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
//    UIView *header=self.headView;
//    [self.tableView setTableHeaderView:header];
    
    
    
}
@end
