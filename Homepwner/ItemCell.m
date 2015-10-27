//
//  ItemCell.m
//  Homepwner
//
//  Created by Mia on 15/10/23.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

-(IBAction)showImage:(id)sender
{
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
