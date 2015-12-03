//
//  showPhotoWithModalView.m
//  Zaker
//
//  Created by Mia on 15/12/2.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "showPhotoWithModalView.h"

@interface showPhotoWithModalView ()<showPhotoWithCollectionViewDelegate>

@end

@implementation showPhotoWithModalView



-(void)viewDidLoad
{
    [self setImages];
}

-(void)setImages
{
        NSLog(@"image:%@",_image);
        _imageView.image=_image;
}


-(void)getURLofPhoto:(NSArray *)URLofALLphoto atIndexPath:(NSIndexPath *)indexPath
{
    _theURLofPhoto=URLofALLphoto[indexPath.row];
    NSLog(@"%@",_theURLofPhoto);
}
@end
