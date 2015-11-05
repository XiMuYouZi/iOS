//
//  PlayingCardDeck.m
//  CardGame
//
//  Created by Mia on 15/11/4.
//  Copyright (c) 2015年 Mia. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck


//重写init方法，设定扑克牌的花色和大小
//注意这里使用到了instancetype，原因如下：
//PlayingCardDeck是PlayingCard类的子类，而他们都是NSObject的子类，所以init方法总是返回NSObject对象，
//但是我们想返回PlayingCardDeck的对象，这就要求任何集成NSObject的子类都能在init方法中返回自身所在的类。
//instancetype关键字就是起到这个作用的，可以返回一个对象，具有和这条消息将要发送到的的对象具有相同的类型。
//这里的init方法要发送到PlayingCardDeck对象，所以返回的也是PlayingCardDeck对象。
//self=[super init]该语句的作用是：只有父类正常初始化，子类才开始初始化自己
-(instancetype ) init
{
    self=[super init];
    if (self) {
        for (NSString * suit in [PlayingCard validSuits]) {
            for (NSUInteger rank=1; rank<=[PlayingCard maxRank]; rank++) {
                PlayingCard *card=[[PlayingCard alloc]init];
                card.rank=rank;
                card.suit=suit;
                [self addCard:card];  //调用父类Deck的addCard方法
            }
        }
    }
    return self;
}
@end
