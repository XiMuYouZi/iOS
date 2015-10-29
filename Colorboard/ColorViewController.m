//
//  ColorViewController.m
//  Colorboard
//
//  Created by Mia on 15/10/29.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ColorViewController.h"

@interface ColorViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;

@end

@implementation ColorViewController
- (IBAction)changeColor:(id)sender {
    float red=self.redSlider.value;
    float green=self.greenSlider.value;
    float blue=self.blueSlider.value;
    UIColor *newColor=[UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.view.backgroundColor=newColor;
}



-(IBAction)dismiss:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
