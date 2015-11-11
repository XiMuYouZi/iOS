//
//  FlickPhotosTVC.m
//  Shutterbug
//
//  Created by Mia on 15/11/11.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "FlickPhotosTVC.h"
#import "FlickrFetcher.h"
#import "ImageViewController.h"

@interface FlickPhotosTVC ()

@end

@implementation FlickPhotosTVC



//点击masterview中选择的行，在detailview中现实详细的内容.self.splitViewController.viewControllers[1]这句话的表示如果设备是ipad就运行这句话
//因为这句话在iPhone上面也可以运行，但是iPhone上面没有splitviewcontroller，所以不会得到detailviewcontroller
//所以这句话相当于先判断设备类型为iPad，然后得到detailview。不需要明确写判断设备类型的代码
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detail =self.splitViewController.viewControllers[1];
    
//    把detailview放到UINavigation中，这样可以在导航栏显示图片的名字,但是要注意此时detailview变成了UINavigation的rootview了，而不是之前splitviewcontroller的detailview，所以必须先获取到UINavigation的第一个视图，也就是rootview，然后赋给detail
    if ([detail isKindOfClass:[UINavigationController class]]) {
        detail=[((UINavigationController*)detail).viewControllers firstObject];
    }
    if ([detail isKindOfClass:[ImageViewController class]]) {
        [self prepareImageViewController:detail toDisplayPhoto:self.photos[indexPath.row]];
        
    }
}



-(void)prepareImageViewController:(ImageViewController *)ivc toDisplayPhoto:(NSDictionary *)photo
{
//    使用FlickrFetcher类的方法获取照片的url，赋给imageViewController的imageURL属性
    ivc.imageURL=[FlickrFetcher URLforPhoto:photo format:FlickrPhotoFormatLarge];
    
//    设置ImageViewController的title为照片的名字
    ivc.title=[photo valueForKey:FLICKR_PHOTO_TITLE];
}


//设置用户点击的单元格的segue动作
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    使用内省机制，判断点击的单元格是UITableView类
    if ([sender isKindOfClass:[UITableView class]]) {
        
//        获取用户点击的cell
        NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Display Photo"]) {
                
//                使用内省机制，保证segue的目标viewcontroller是ImageViewController
                if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
                    
//                    在imageviewcontroller上显示用户点击的单元格所对应的照片
                    [self prepareImageViewController:segue.destinationViewController
                                      toDisplayPhoto:self.photos[indexPath.row]];
                }
            }
        }
    }
}


//获取了photo就更新整个tableview
-(void)setPhotos:(NSArray *)photos
{
    _photos=photos;
    [self.tableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}


//绘制tableviewCell的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"Fetch Photo Cell";
    
//    定义重用tableviewcell
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
//    定义每个单元格的现实的内容
    NSDictionary *photo =self.photos[indexPath.row];
//    定义单元格的主标题内容
    cell.textLabel.text=[photo valueForKey:FLICKR_PHOTO_TITLE];
//    定义副标题的内容
    cell.detailTextLabel.text=[photo valueForKey:FLICKR_PHOTO_DESCRIPTION];
    return  cell;
}
@end
