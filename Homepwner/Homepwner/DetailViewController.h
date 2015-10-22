//
//  DetailViewController.h
//  Homepwner
//
//  Created by Mia on 15/10/19.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRItem;


@interface DetailViewController : UIViewController
-(instancetype)initForNewItem:(BOOL)isNew;

@property (nonatomic,strong)   BNRItem *item;
//申明一个指向block对象的属性，该block对象在itemsviewcontroller中创建，实现了两个页面之间的传值
@property(nonatomic ,copy)void(^dismissBlock)(void);

@end
