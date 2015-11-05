//
//  Deck.m
//  CardGame
//
//  Created by Mia on 15/11/3.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "Deck.h"

@interface Deck ( )
@property (strong,nonatomic)NSMutableArray *cards;

@end

@implementation Deck

//这里重写了cards得gettar方法，是为了初始化cards，给他分配内存空间，这样-(void)addCard:(Card *)card atTop:(BOOL)atTop
//方法中的[self.cards insertObject:card atIndex:0]才会有效。因为默认的gettar方法产生的cards是nil，那么self.cards调用的方法
//insertObject方法是不会又任何作用的。所以必须先把在cards的gettar方法中初始化cards使其不是nil，insertObjecct方法才会有效
-(NSMutableArray *)cards
{
    if (!_cards) {
        _cards=[[NSMutableArray alloc]init];
    }
    return  _cards;
}



-(void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
        
    }else{
        [self.cards addObject:card];
    }
}




-(void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}



//随机从牌堆中抽取一张牌
-(Card *)drawRandomCard
{
//    设置randomCard的默认值是nil，然后在if语句中设置randomcard，如果失败，仍旧可以返回默认值，这是一种良好的编程风格
    Card *randomCard=nil;
    if ([self.cards count]) {
        unsigned index=arc4random() %[self.cards count];
        randomCard=self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end
