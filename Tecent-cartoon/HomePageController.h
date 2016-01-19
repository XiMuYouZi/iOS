//
//  HomePageController.h
//  Tecent-cartoon
//
//  Created by Mia on 16/1/16.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomePageController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableView;

@end
