//
//  WSRecommendUserCell.m
//  仿写-百思不得姐
//
//  Created by Mia on 16/2/29.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "WSRecommendUserCell.h"
#import  <UIImageView+WebCache.h>
#import "WSRecommendUserModel.h"

@interface WSRecommendUserCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@end


@implementation WSRecommendUserCell

-(void)setUser:(WSRecommendUserModel *)user
{
    _user=user;
//    设置用户头像
    [self.headerImageView  sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
//    设置用户名字
    self.screenNameLabel.text=user.screen_name;
    
//    设置粉丝数
    self.fansCountLabel.text=[NSString stringWithFormat:@"%zd人关注", user.fans_count];
}

@end
