//
//  ColorDescription.m
//  Colorboard
//
//  Created by Mia on 15/10/29.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ColorDescription.h"

@implementation ColorDescription

-(instancetype)init{
    self=[super init];
    if (self) {
        _color=[UIColor colorWithRed:0
                               green:0
                                blue:1
                               alpha:1];
        _name=@"Blue";
    }
    return  self;
}
@end
