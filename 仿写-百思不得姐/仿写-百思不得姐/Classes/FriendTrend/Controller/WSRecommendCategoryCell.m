//
//  WSRecommendCategoryCell.m
//  仿写-百思不得姐
//
//  Created by Mia on 16/2/28.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "WSRecommendCategoryCell.h"

@interface WSRecommendCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation WSRecommendCategoryCell

- (void)awakeFromNib {
    self.backgroundColor = WSRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = WSRGBColor(219, 21, 26);

}



-(void)setCategory:(WSRecommendCategoryModel *)category
{
    _category=category;
    self.textLabel.text = category.name;
//    WSLog(@"%@",self.textLabel.text);
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    减小系统cell自带的label的高度，这样才不至于挡住cell下面的分割线
    self.textLabel.height=self.contentView.height-2;
}


//cell被选中才显示左侧的指示条
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectedIndicator.hidden =! selected;
    self.textLabel.textColor=selected ? self.selectedIndicator.backgroundColor : WSRGBColor(78, 78, 78);
}

@end
