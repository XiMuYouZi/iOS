//
//  ViewController.m
//  AD
//
//  Created by Mia on 15/12/24.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ViewController.h"
#import <iAD/iAD.h>

@interface ViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

-(void)viewDidLoad
{
    self.textField.keyboardType=UIKeyboardTypeWebSearch;
    
    self.textField.delegate=self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}



@end
