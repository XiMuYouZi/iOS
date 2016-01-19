//
//  ViewController.m
//  1
//
//  Created by Mia on 16/1/2.
//  Copyright © 2016年 Mia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray  *array1=[[NSMutableArray alloc]init];
    NSMutableArray *array2=[[NSMutableArray alloc]init];
    [array1 addObject:array2];
    [array2 addObject:array1];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
