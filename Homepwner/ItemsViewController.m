//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Mia on 15/10/15.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ItemsViewController.h"
#import "DetailViewController.h"
#import "BNRItem.h"
#import "ItemStore.h"
#import "DetailViewController.h"
#import "ImageViewController.h"
#import "ImageStore.h"

@interface ItemsViewController ()<UIPopoverControllerDelegate>
@property (nonatomic,strong)UIPopoverPresentationController *imagePopover;

@end


@implementation ItemsViewController



//修改detaiviewcontroller的数据之后需要重新更新tebleview的数据才可以看见
//更改后的表格行
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self updateTableViewForDynamicTypeSize];
//}
//
//
////动态更改ItemsViewController界面的字体大小
//-(void)updateTableViewForDynamicTypeSize
//{
//    static NSDictionary *cellHeightDictonary;
//    if (!cellHeightDictonary) {
//        cellHeightDictonary=@{
//                              UIContentSizeCategoryExtraSmall:@44,
//                              UIContentSizeCategorySmall:@44,
//                              UIContentSizeCategoryMedium:@44,
//                              UIContentSizeCategoryLarge:@44,
//                              UIContentSizeCategoryExtraLarge:@55,
//                              UIContentSizeCategoryExtraExtraLarge:@65,
//                              UIContentSizeCategoryExtraExtraExtraLarge:@75
//                              };
//        
//        NSString *userSize=[[UIApplication sharedApplication]preferredContentSizeCategory];
//        NSNumber *cellHeight=cellHeightDictonary[userSize];
//        [self.tableView setRowHeight:cellHeight.floatValue];
        [self.tableView reloadData];
//    }
}



//当用户点击tableview对象中的某个表格行，该对象会向其委托对象itemsviewcontroller
//发送tableview：didselectatindexpath：消息，那么如果需要再detailviewcontroller显示之前做一些动作，就可以在该方法中来实现
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //使用自定义的初始化方法来初始化，而不是使用父类的初始化方法
    DetailViewController *detailViewController=[[DetailViewController alloc]initForNewItem:NO];
    
    //在detailviewcontroller对象收到viewwillapper：消息之前将该对象的item属相设置为响应的BNRitem对象
    NSArray *items=[[ItemStore sharedStore]allItems];
    BNRItem *selectItem=items[indexPath.row];
    detailViewController.item=selectItem;
    
    
    //在该方法中实现当用户点击某行的时候，就创建detailviewcontroller对象并压入navigationcontroller对象栈
//    [self presentViewController:detailViewController animated:YES completion:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
}



//实现tableview的移动行的功能
- (void)tableView:(UITableView *)tableView
  moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
         toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[ItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row
                                        toIndex:destinationIndexPath.row];
    
}



//实现edit按钮下面的删除功能
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSArray *items=[[ItemStore sharedStore]allItems];
        BNRItem *item=items[indexPath.row];
        [[ItemStore sharedStore]removeItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
    }
}



//实现+按钮的功能，可以用模态形式添加条目
-(IBAction)addNewItem:(id)sender
{
    BNRItem *newItem=[[ItemStore sharedStore]createItem];
    
//    先创建一个新的DetailViewController对象，然后创建一个新的UINavigationController 对象，
//    然后把DetailViewController作为UINavigationController的根viewcontroller，然后用模态形式显示UINavigationController
    DetailViewController *detailViewController=[[DetailViewController alloc]initForNewItem:YES];
    detailViewController.item=newItem;
    
//    当用户点+按钮添加一个BNRItem对象的时候，itemsviewcontroller会创建一个
//    block对象并且指向detailviewcontroller对象的属性dismissblock属性
//    该block对象的作用是负责刷新itemsviewcontroller的UITableView
    detailViewController.dismissBlock=^{[self.tableView reloadData];};
    
    UINavigationController *navController =[[UINavigationController alloc]initWithRootViewController:detailViewController];
//    用页表单形式显示模态视图,注意这里修改的是navigationcontroller的modalpresenttation，而不是detailviewcontroller，因为以模态显示视图控制器的是navigationcontroller
    navController.modalPresentationStyle=UIModalPresentationFormSheet;
    
    
//    navController.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
//    navController.modalPresentationStyle=UIModalPresentationCurrentContext;
//    self.definesPresentationContext=YES;
    
//    因为用formsheet模态显示DetailViewController的时候，ItemsViewController并没有消失，所以viewwillappear和viewdidappear不能被加载，所以必须在ItemsViewController
//    的某个方法中提前完成添加功能
    [self presentViewController:navController animated:YES completion:nil];
    
    
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
      
//        启动APP的时候，ItemsViewController会根据用户设置的字体更改界面字体的大小
        NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(updateTableViewForDynamicTypeSize) name:UIContentSizeCategoryDidChangeNotification object:nil];

    }
    return  self;
}


-(void)dealloc
{
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
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
    return [[[ItemStore sharedStore]allItems]count];
}



//让tableview的第n行显示allitem数组中的第n个BNRitem对象
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建tableviewcell对象，每行表格使用默认风格,无法重tableviewcell
    //UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
//根据重用标示创建ItemCell对象
    ItemCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    

    //获取allItems的第n个BNRItem对象，让后讲BNRitem对象的description赋给tableviewcell对象的textlabel
    //这里的n就是该tableviewcell对象的对应的表格的行索引
    NSArray *items=[[ItemStore sharedStore]allItems];
    BNRItem *item=items[indexPath.row];
    cell.nameLabel.text=item.itemName;
    cell.serialNumberLabel.text=item.serialNumber;
    cell.vauleLabel.text=[NSString stringWithFormat:@"$%d",item.valueInDollars];
    cell.thumbnailView.image=item.thumbnail;
    
    /*下面的代码是按照书上写的，但是203和204行一直提示有错误
    __weak ItemCell *weakCell = cell;
    cell.actionBlock=^{
        NSLog(@"Going to show image for%@",item);
        ItemCell *strongCell = weakCell;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            NSString *itemKey = item.itemKey;
            // If there is no image, we don't need to display anything
            UIImage *img = [[ImageStore shareStore] imageForKey:itemKey];
            if (!img) {
                return; }
            // Make a rectangle for the frame of the thumbnail relative to
            // our table view
            CGRect rect = [self.view convertRect:strongCell.thumbnailView.bounds
                                        fromView:strongCell.thumbnailView];
            // Create a new BNRImageViewController and set its image
            ImageViewController *ivc = [[ImageViewController alloc] init];
            ivc.image = img;
            // Present a 600x600 popover from the rect
            self.imagePopover = [[UIPopoverController alloc]
                                 initWithContentViewController:ivc];
            self.imagePopover.delegate = self;
            self.imagePopover.popoverContentSize = CGSizeMake(600, 600);
            [self.imagePopover presentPopoverFromRect:rect
                                               inView:self.view
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
        }
    };*/
    
    return cell;
    
}




//覆盖viewdidload方法，让系统来自动重建tableviewcell对象，viewdidload是当通过NIB或者代码方式加载view到内存之后，需要重新调整view的时候调用
-(void)viewDidLoad
{
    [super viewDidLoad];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
//    UIView *header=self.headView;
//    [self.tableView setTableHeaderView:header];
    
//    根据文件名为ItemCell的NIB文件创建NIB对象
    UINib *nib=[UINib nibWithNibName:@"ItemCell" bundle:nil];
//    注册ItemCell.xib文件，设置重用标示
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ItemCell"];
    
}
@end
