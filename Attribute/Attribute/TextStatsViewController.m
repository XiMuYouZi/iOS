//
//  TextStatsViewController.m
//  Attribute
//
//  Created by Mia on 15/11/7.
//  Copyright (c) 2015年 Mia. All rights reserved.

//这个ViewController的作用就是对textstatsviwecontroller这个可变属性string进行分析得出被改变颜色和加了轮廓的字符的个数

#import "TextStatsViewController.h"

@interface TextStatsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *colorfulCharatersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlineCharatersLabel;

@end

@implementation TextStatsViewController



//一旦设置了TextStatsViewController，那么说明就有字符被改变了样式，就要更新我的界面UI，也就是开始计算被改变的字符个数
//self.view.window是当前视图所在的窗口，view指的是你的mvc的顶级视图，如果他是nil，那么你现在不在屏幕上。
//如果有人设置了待分析的文本，而且textstatsviewcontroller在屏幕上，那么self自己更新ui，否则就让viewwillappear更新ui
-(void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze=textToAnalyze;
    if (self.view.window) {
        [self updateUI];
    }
}

//当textstatsviewcontroller不在屏幕上的时候设置了TextStatsViewController，比如两个label还没有准备好，
//那么上面的使用TextStatsViewController的getter方法更新ui就不会被调用，那么此时就要调用viwewillappear方法来更新UI
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}


//找出被改变了颜色或者轮廓的字符个数
-(NSAttributedString *) characterWithAttribute: (NSString *) attributeName
{
    NSMutableAttributedString * characters=[[NSMutableAttributedString alloc]init];
    
    NSUInteger index=0;
    while (index<[self.textToAnalyze length]) {
        NSRange range;
        //        在index处查看是否由字符满足属性名字为attributeName的属性，如果满足，返回从index处具有相同属性的字符的范围，比如在index=3处，连续又5个字符都
        //        被改变了颜色，就返回这五个字符的所在的range（3，5）
        id value=[self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range]; //因为返回可能是颜色，或者轮廓，所以使用id类型，&range是range的指针
        if (value) {
            //            如果有满足要求的字符，就加入characters
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index=range.location+range.length;  //更新index到当前index+匹配字符长度的下一位
        }else{
            index++; //没有找到，就继续找下一个字符
        }
        
    }
    return  characters;

}



-(void)updateUI
{
    self.colorfulCharatersLabel.text=[NSString stringWithFormat:@"%lu colorful charactrers",
                                      (unsigned long)[[self characterWithAttribute:NSForegroundColorAttributeName]length]]; //调用characterwithattribut方法计算染色的字符个数
    
    
    self.colorfulCharatersLabel.text=[NSString stringWithFormat:@"%lu outlined charactrers",
                                      (unsigned long)[[self characterWithAttribute:NSStrokeWidthAttributeName]length]];//调用characterwithattribut方法计算轮廓的字符个数
}

@end
