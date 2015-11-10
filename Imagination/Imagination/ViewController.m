//
//  ViewController.m
//  Imagination
//
//  Created by Mia on 15/11/10.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()


@end

@implementation ViewController

//把需要下载图片的url赋值给ImageViewController的属性imageURL
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        ImageViewController *ivc=(ImageViewController *)segue.destinationViewController;
        ivc.imageURL=[NSURL URLWithString:[NSString stringWithFormat:
                                           @"http://images.apple.com/v/iphone-5s/gallery/a/images/download/%@.jpg",segue.identifier ]];
    }
}

@end
