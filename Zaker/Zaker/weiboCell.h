//
//  weiboCell.h
//  Zaker
//
//  Created by Mia on 15/12/4.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface weiboCell : UITableViewCell
@property(strong,nonatomic)UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UILabel *Content;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;

@end
