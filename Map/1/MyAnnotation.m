//
//  MyAnnotation.m
//  1
//
//  Created by Mia on 15/12/23.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
-(NSString *)title
{
    return @"你的位置：";
}

-(NSString *)subtitle
{
    NSMutableString *ret=[NSMutableString new];
    
    if (_state) {
        [ret appendString:_state];
    }
    
    if (_city) {
        [ret appendString:_city];
    }
    
    if (_street) {
        [ret appendString:_street];
    }
    
    return  ret;
}
@end

