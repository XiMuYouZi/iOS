//
//  FetchPhotoController.m
//  Zaker
//
//  Created by Mia on 15/11/22.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "FetchPhotoCell.h"

@implementation FetchPhotoCell


- (id)initWithFrame:(CGRect)frame
{
    self.backgroundColor=[UIColor whiteColor];
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Setup
- (void)setup
{
    [self setupImage];
}


- (void)setupImage
{
    self.PhotoImageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
//    self.PhotoImageView.contentMode=UIViewContentModeScaleAspectFill;
    
    [self addSubview:self.PhotoImageView];
                           
}



@end
