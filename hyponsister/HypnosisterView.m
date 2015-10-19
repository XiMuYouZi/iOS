//
//  HypnosisterView.m
//  Hypnosister
//
//  Created by Mia on 15/9/16.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "HypnosisterView.h"

@interface HypnosisterView()
@property (strong,nonatomic) UIColor *circleColor;


@end

@implementation HypnosisterView

-(void)drawRect:(CGRect)rect
{
    CGRect bounds =self.bounds;
    CGPoint center;
    center.x=bounds.origin.x+bounds.size.width/2.0;
    center.y=bounds.origin.y+bounds.size.height/2.0;
    
    float maxRadius=(hypot(bounds.size.width, bounds.size.height)/2.0);
    UIBezierPath  *path=[[UIBezierPath alloc]init];
    
    for (float currentRadius=maxRadius; currentRadius>0; currentRadius-=10) {
    [path moveToPoint:CGPointMake(center.x+currentRadius, center.y)];
    [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    }
    
    path.lineWidth=2;
    [self.circleColor setStroke];
    [path stroke];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.circleColor=[UIColor lightGrayColor];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ WAS TOUCHED",self);
    float red =(arc4random()%100)/100.0;
    float green=(arc4random()%100)/100.0;
    float blue=(arc4random()%100)/100.0;
    
    UIColor *randomColor=[UIColor colorWithRed:red
                                             green:green
                                              blue:blue
                                             alpha:1.0];
    self.circleColor=randomColor;
}

//重绘frame
-(void)setCircleColor:(UIColor *)circleColor
{
    _circleColor=circleColor;
    [self setNeedsDisplay];
}

@end
