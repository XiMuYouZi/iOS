//
//  DrawViewController.m
//  TouchTacker
//
//  Created by Mia on 15/10/20.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawView.h"

@interface DrawViewController ()

@end

@implementation DrawViewController

-(void)loadView
{
    self.view=[[DrawView alloc]initWithFrame:CGRectZero];
}
@end
