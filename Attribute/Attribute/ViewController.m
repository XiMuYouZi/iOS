//
//  ViewController.m
//  Attribute
//
//  Created by Mia on 15/11/5.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation ViewController


//当在设置里面更改了字体大小，body和headline里面的字体大小也会被更改
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(preferredFontsChanged:)
                                                name:UIContentSizeCategoryDidChangeNotification object:nil];
    
}

//设置body和headline的字体样式

-(void)preferredFontsChanged:(NSNotificationCenter *)notification
{
    self.body.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font=[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}


-(void)usePreferredFonts
{
    }

//给按钮的标题设置轮廓
-(void)viewDidLoad
{
    [super viewDidLoad];
//    因为按钮的title默认是无法编辑的，必须先转换为可变的属性string类型，然后才可以被编辑
    NSMutableAttributedString *title=[[NSMutableAttributedString alloc]initWithString:self.outlineButton.currentTitle];
//    设置按钮title的轮廓
    [title setAttributes:@{NSStrokeWidthAttributeName:@-3,
//                           得到按钮的颜色，使用按钮的颜色作为轮廓的颜色
                           NSStrokeColorAttributeName:self.outlineButton.tintColor}
                   range:NSMakeRange(0, title.length)];
//    把设置之后的可变属性string赋给按钮的的title属性，这样就可以改变按钮的title属性
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal] ;
}



- (IBAction)changeBodyTextColor:(UIButton *)sender
{
//    设置body的前景色为点击按钮的背景色，前景色就是textview上字体的颜色，只改变被选择字体的颜色
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
}



//    给选择的字加上轮廓
- (IBAction)outlineBodySelection:(UIButton *)sender {
   /* NSStrokeColorAttributeName
    The value of this parameter is a UIColor object. If it is not defined (which is the case by default), it is assumed to be the same as the value of NSForegroundColorAttributeName; otherwise, it describes the outline color. For more details, see Drawing attributed strings that are both filled and stroked.
    
    Available in iOS 6.0 and later.
    NSStrokeWidthAttributeName
    The value of this attribute is an NSNumber object containing a floating-point value. This value represents the amount to change the stroke width and is specified as a percentage of the font point size. Specify 0 (the default) for no additional changes. Specify positive values to change the stroke width alone. Specify negative values to stroke and fill the text. For example, a typical value for outlined text would be 3.0.*/
    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName:@3,
                                           NSStrokeColorAttributeName:[UIColor blackColor]}
                                   range:self.body.selectedRange];
}



//去掉轮廓
- (IBAction)unoutlineBodySelection:(UIButton *)sender {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                     range:self.body.selectedRange];
}

@end
