//
//  buttonView.m
//  test
//
//  Created by Mia on 16/1/22.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "buttonView.h"

@implementation buttonView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor redColor];
        
        [self addSubview:self.button];
    }
    return self;
}




-(UIButton*)button
{
    if (!_button)
    {
    _button=[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100 , 100)];
    _button.backgroundColor=[UIColor blueColor];
    [_button setTitle:@"按钮" forState:UIControlStateNormal];
    }
    return _button;
}


@end
