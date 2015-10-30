//
//  BNRColorViewController.h
//  Colorboard
//
//  Created by John Gallagher on 1/10/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorDescription.h"

@interface ColorViewController : UIViewController

@property (nonatomic) BOOL existingColor;
@property (nonatomic) ColorDescription *colorDescription;

@end

