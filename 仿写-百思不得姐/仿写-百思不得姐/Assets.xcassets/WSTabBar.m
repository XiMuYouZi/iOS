//
//  WSTabBar.m
//  仿写-百思不得姐
//
//  Created by Mia on 16/2/28.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "WSTabBar.h"

@interface WSTabBar()
@property(nonatomic,weak)UIButton *publishButton;

@end

@implementation WSTabBar
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        publishButton.size = publishButton.currentBackgroundImage.size;

        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}







- (void)layoutSubviews

{
    

    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    
    // 设置发布按钮的frame
    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    //    只布局UITabBar的原生按钮
    for (UIView *button in self.subviews) {
        
        //        tabBar的原生按钮都是UITabBarButton，但是他们是私有的类，无法直接使用isKindOfClass:[UITabBarButton class]]来调用，所以只能用isKindOfClass:NSClassFromString(@"UITabBarButton")]调用，因为tabBar的原生按钮都是UITabBarButton，而我们加在中间的按钮是UIButton，所以下面这句代码出去了我们自定义的UIButton
        if ([button isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            
            //        也可以使用下面的方法实现和上面代码一样的功能
            //        if ([button isKindOfClass:[UIControl class]] && button != self.publishButton)
            
            // 计算按钮的x值
            CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            
            // 增加索引
            index++;
        }
    }
}

@end
