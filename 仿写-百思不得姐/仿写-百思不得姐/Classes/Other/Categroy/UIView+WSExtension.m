//
//  UIView+WSExtension.m
//  仿写-百思不得姐
//
//  Created by Mia on 16/2/28.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "UIView+WSExtension.h"

@implementation UIView (WSExtension)

-(void)setSize:(CGSize)size
{
    CGRect frames=self.frame;
    frames.size=size;
    self.frame=frames;
}

-(CGSize)size
{
    return self.frame.size;
}


-(void)setWidth:(CGFloat)width
{
    CGRect frames=self.frame;
    frames.size.width=width;
    self.frame=frames;
}

-(CGFloat)width
{
    return self.frame.size.width;
}


-(void)setHeight:(CGFloat)height
{
    CGRect frames=self.frame;
    frames.size.height=height;
    self.frame=frames;
}

-(CGFloat)height
{
    return self.frame.size.height;
}


-(void)setX:(CGFloat)x
{
    CGRect frames=self.frame;
    frames.origin.x=x;
    self.frame=frames;
}

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y
{
    CGRect frames=self.frame;
    frames.origin.y=y;
    self.frame=frames;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}


@end
