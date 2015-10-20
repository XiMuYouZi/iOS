//
//  DrawView.m
//  TouchTacker
//
//  Created by Mia on 15/10/20.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "DrawView.h"
#import "BNRLine.h"

@interface DrawView()
@property (nonatomic,strong)BNRLine * currentLine;
@property(nonatomic ,strong)NSMutableArray *finishedLines;
@property (nonatomic ,strong)NSMutableDictionary *lineInProgress;
@property(nonatomic,weak)BNRLine *selectLine;

@end

@implementation DrawView


//完成初始化任务
-(instancetype)initWithFrame:(CGRect)r
{
    self=[super initWithFrame:r];
    if (self) {
        self.lineInProgress=[[NSMutableDictionary alloc]init];
        self.finishedLines=[[NSMutableArray alloc]init];
        self.backgroundColor=[UIColor grayColor];
        self.multipleTouchEnabled=YES;
        
//        双击清除屏幕的所有线条
        UITapGestureRecognizer *doubleTapRecognizer=[[UITapGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired=2;
        doubleTapRecognizer.delaysTouchesBegan=YES;
        [self addGestureRecognizer:doubleTapRecognizer];

        
        
//        单击选中线条
        UITapGestureRecognizer *tapReconginzer=[[UITapGestureRecognizer alloc]
                                                initWithTarget:self
                                                action:@selector(tap:)];
        tapReconginzer.delaysTouchesBegan=YES;
        [tapReconginzer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapReconginzer];
        
            }
    return self;
}


//双击清除线条
-(void)doubleTap:(UIGestureRecognizer *)gr
{
    [self.lineInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    [self setNeedsDisplay];
}


//单击选择线条,显示uimenuitem
-(void)tap:(UIGestureRecognizer *)gr
{
    NSLog(@"tap");
    CGPoint point=[gr locationInView:self];
    self.selectLine=[self lineAtPoint:point];
    
    if (self.selectLine) {
//        使点击的视图成为UIMenuItem动作消息的目标
        [self becomeFirstResponder];
        
//        获取UIMenuController对象
        UIMenuController *menu=[UIMenuController sharedMenuController];
        
//        创建一个标题为delete的UIMenuItem对象
        UIMenuItem *deleteItem=[[UIMenuItem alloc]initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems=@[deleteItem];
        
//        设置UIMenuItem的显示区域，然后设置其可见
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
    }else{
//        没有选中线条就隐藏UIMenuItem
        [[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];
    }
    [self setNeedsDisplay];
}


//要显示UIMenuItem，必须让显示UIMenuItem对象的UIView对象（DrawView）成为UIWindow对象的第一响应对象
-(BOOL)canBecomeFirstResponder
{
    return YES;
}


-(void)deleteLine:(id)sender
{
    [self.finishedLines removeObject:self.selectLine];
    [self setNeedsDisplay];
}

//绘制线条
-(void)strokeLine:(BNRLine *)line
{
    UIBezierPath *bp=[UIBezierPath bezierPath];
    bp.lineWidth=10;
    bp.lineCapStyle=kCGLineCapRound;
    [bp moveToPoint:line.Begin];
    [bp addLineToPoint:line.End];
    [bp stroke];
    
}


-(void)drawRect:(CGRect)rect
{
//    用黑色绘制已经完成的线条
    [[UIColor blackColor]set];
    for (BNRLine *line in self.finishedLines) {
        [self strokeLine:line];
    }
    
    [[UIColor redColor]set];
    for (NSValue * key in self.lineInProgress) {
        [self strokeLine:self.lineInProgress[key]];
    }
    
    if (self.selectLine) {
        [[UIColor greenColor]set];
        [self strokeLine:self.selectLine];
    }
    
}


//找出离点击位置最近的线条
-(BNRLine *)lineAtPoint:(CGPoint)p
{
    for (BNRLine *l in self.finishedLines) {
        CGPoint start=l.Begin   ;
        CGPoint end =l.End;
//        在线条上面取20个点的x，y和屏幕点击位置的x，y 做对比，如果差值在20个点以内，就选择该线条为距离手指点击的点最近的线条
        for (float t=0.0; t<=1.0; t+=0.05) {
            float x=start.x+t*(end.x-start.x);
            float y=start.y+ t*(end.y-start.y);
            if (hypot(x-p.x, y-p.y)<20.0) {
                return l;
            }
        }
    }
//    找不到这样的线条就返回nil
    return nil;
}


//实现多点触摸，同时绘制多根线条
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    
    for (UITouch *t in touches) {
        CGPoint location=[t locationInView:self];
        BNRLine *line =[[BNRLine alloc]init];
        line.Begin=location;
        line.End=location;
//        使用valueWithNonretainedObject把UITouch对象的内存地址封装为nsvaule，作为BNRLine的key
        NSValue *key=[NSValue valueWithNonretainedObject:t];
        self.lineInProgress[key]=line;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        NSValue *key=[NSValue valueWithNonretainedObject:t];
        BNRLine * line =self.lineInProgress[key];
        line.End=[t locationInView:self];
    }
    
    [self setNeedsDisplay];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    for (UITouch * t  in touches) {
        NSValue *key=[NSValue valueWithNonretainedObject:t ];
        BNRLine * line=self.lineInProgress[key];
        [self.finishedLines addObject:line];
        [self.lineInProgress removeObjectForKey:key];
    }[self setNeedsDisplay];
}



-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        NSValue *key=[NSValue valueWithNonretainedObject:t ];
        [self.lineInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}










































@end
